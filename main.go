package main

import (
	"math/rand"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	// 基础 Ping 接口
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	// 分支逻辑测试接口：根据 query 参数 'n' 的值返回不同结果
	r.GET("/check", func(c *gin.Context) {
		nStr := c.Query("n")
		n, err := strconv.Atoi(nStr)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "invalid number"})
			return
		}

		if n > 100 {
			c.JSON(http.StatusOK, gin.H{"status": "high", "value": n})
		} else if n > 50 {
			c.JSON(http.StatusOK, gin.H{"status": "medium", "value": n})
		} else {
			c.JSON(http.StatusOK, gin.H{"status": "low", "value": n})
		}
	})

	// 复杂分支测试接口：计算器
	r.GET("/calc", func(c *gin.Context) {
		op := c.Query("op")
		aStr := c.Query("a")
		bStr := c.Query("b")

		a, errA := strconv.Atoi(aStr)
		b, errB := strconv.Atoi(bStr)

		if errA != nil || errB != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "invalid operands"})
			return
		}

		var result int
		switch op {
		case "add":
			result = a + b
		case "sub":
			result = a - b
		case "mul":
			result = a * b
		case "div":
			if b == 0 {
				c.JSON(http.StatusBadRequest, gin.H{"error": "division by zero"})
				return
			}
			result = a / b
		default:
			c.JSON(http.StatusBadRequest, gin.H{"error": "unknown operation"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"result": result})
	})

	// 随机逻辑接口
	r.GET("/random", func(c *gin.Context) {
		v := rand.Intn(10)
		if v%2 == 0 {
			if v == 0 {
				c.JSON(http.StatusOK, gin.H{"msg": "zero is even", "val": v})
			} else {
				c.JSON(http.StatusOK, gin.H{"msg": "even number", "val": v})
			}
		} else {
			c.JSON(http.StatusOK, gin.H{"msg": "odd number", "val": v})
		}
	})

	r.Run(":8081")
}
