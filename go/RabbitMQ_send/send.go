package main

import (
	"encoding/json"
	"fmt"
	"log"

	"github.com/streadway/amqp"
)

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

//Message ...
type Message struct { //json重命名
	Username string `json:"username"` //用户名
	Password string `json:"password"` //密码
	Actid    int    `json:"actid"`    //活动id
}

func main() {
	//连接信息修改为自己的服务器账户名和密码
	conn, err := amqp.Dial("amqp://账户名:密码@localhost:5672/")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	q, err := ch.QueueDeclare(
		"hello", // name
		false,   // durable
		false,   // delete when unused
		false,   // exclusive 独有的
		false,   // no-wait
		nil,     // arguments
	)
	failOnError(err, "Failed to declare a queue")

	//构造一条消息<待完善：应从秒杀界面直接传递过来>
	// body := "Hello World!"
	message := Message{
		Username: "2001210671",
		Password: "pwd1",
		Actid:    1,
	}
	fmt.Println(message)
	body, err := json.Marshal(message) //将数据编码成json字符串

	//发送消息到队列
	err = ch.Publish(
		"",     // exchange
		q.Name, // routing key
		false,  // mandatory
		false,  // immediate
		amqp.Publishing{
			ContentType: "text/plain",
			Body:        body,
		})
	log.Printf(" [x] Sent %s", body)
	failOnError(err, "Failed to publish a message")
}
