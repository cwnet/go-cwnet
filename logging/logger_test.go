package logging

import "testing"

func TestJsonLogger(t *testing.T) {
	InitLogger("../", "test.log", "debug", "json")
	Printf("test for logger:%v", "gogogogo")
}

func TestTextLogger(t *testing.T) {
	InitLogger("../", "test.log", "debug", "")
	Printf("test for logger:%v", "gogogogo")
}
