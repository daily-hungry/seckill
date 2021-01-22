package main

import (
	"encoding/json"
	"fmt"
	"log"

	"github.com/streadway/amqp"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
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

//Activity...
type Activity struct {
	ID        int    `gorm:"primaryKey"`
	Name      string `gorm:"column:name"`
	Time      string `gorm:"column:time"`
	Place     string `gorm:"column:place"`
	Sum       int    `gorm:"column:sum"`
	Remain    int    `gorm:"column:remain"`
	Info      string `gorm:"column:info"`
	StartTime int    `gorm:"column:starttime"`
}

//Student ...
type Room struct {
	ID        int    `gorm:"primaryKey"`
	UserName  string `gorm:"column:username"`
	Password  string `gorm:"column:password"`
	Name      string `gorm:"column:name"`
	Token     string `gorm:"column:token"`
	LoginTime int    `gorm:"column:logintime"`
	State     int    `gorm:"column:state"`
}

//Sign ...
type Sign struct {
	ID      int    `gorm:"primaryKey"`
	StuID   int    `gorm:"column:stuid"`
	ActID   int    `gorm:"column:actid"`
	GetTime int    `gorm:"column:gettime"`
	Info    string `gorm:"column:info"`
}

func main() {
	// conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
	conn, err := amqp.Dial("amqp://wangyu:1234wangyu@8.131.66.9:5672/")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	//连接数据库----填自己的数据库相关内容
	//host指主机地址,port指端口号,user指用户名,dbname指数据库名,password指密码
	dsn := "user:password@tcp(host:port)/dbname?charset=utf8&parseTime=True"
	db := ConnectDB(dsn)

	q, err := ch.QueueDeclare(
		"hello", // name
		false,   // durable
		false,   // delete when unused
		false,   // exclusive
		false,   // no-wait
		nil,     // arguments
	)
	failOnError(err, "Failed to declare a queue")

	msgs, err := ch.Consume(
		q.Name, // queue
		"",     // consumer
		true,   // auto-ack
		false,  // exclusive
		false,  // no-local
		false,  // no-wait
		nil,    // args
	)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	go func() {
		for d := range msgs { //按先后顺序依此处理
			log.Printf("Received a message: %s", d.Body)
			//接收到消息后处理消息-------------------(填充处理逻辑)
			fmt.Printf("处理消息\n")
			message := Message{}
			err := json.Unmarshal(d.Body, &message) //将json字符串解析到message中
			if err != nil {
				fmt.Println("生成json字符串错误")
			}
			process(message, db) //处理消息
		}
	}()

	log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
	<-forever
}

func process(message Message, db *gorm.DB) {
	//参数
	username := message.Username
	password := message.Password
	actid := message.Actid
	//处理逻辑

	// 检查：若当前用户处于已报名状态，则选择失败，给出提示
	// 检查：若用户用户名密码错误，则选择失败，给出提示
	// 检查：当前所选活动id是否还有剩余名额，若无，则选择失败给出提示
	// 检查都通过后逐个更新信息表(isok==1)
	isok := 1
	// 开始事务
	tx := db.Begin()

	if isok == 1 {
		// 要更新三个表
		// 1.students表，修改是否已报名活动的状态
		err := db.Table("students").Where(" username = ?", username).Update("state", 1).Error //修改已报名的状态为已报名
		if err != nil {                                                                       //如果修改失败，要回滚，保证一致性
			tx.Rollback()
			return
		}
		// 2.activities表，修改活动剩余可报名额
		// 3.signs表，增添该用户成功报名活动的报名信息
		// 逻辑思路与php实现的相同，后续再完善，2.3和1相同，如果修改数据库时出现错误都要进行回滚，保证一致性。
	} else {
		fmt.Println("选择宿舍失败！")
	}
	// 否则，提交事务
	tx.Commit()
}

// ConnectDB ... 连接数据库
func ConnectDB(dsn string) (db *gorm.DB) {
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("------------连接数据库成功------------")
	return db
}
