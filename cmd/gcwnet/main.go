package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strconv"
	"time"

	cli "gopkg.in/urfave/cli.v1"
)

var (
	gitCommit = ""
	version   = ""
	branch    = ""
	compileAt = ""
	app       = cli.NewApp()
)

func init() {
	app.Action = gcwnet
	app.Name = filepath.Base(os.Args[0])
	app.Author = ""
	app.Email = ""
	app.Version = version + "-" + gitCommit[:8]
	timestamp, _ := strconv.ParseInt(compileAt, 10, 64)
	app.Compiled = time.Unix(timestamp, 0)
	app.Version = fmt.Sprintf("%s\n branch: %s\n commit: %s\n compileAt:%s",
		version, branch, gitCommit, app.Compiled)

	app.Copyright = "Copyright 2018 The go-gcwnet Authors"
	app.Usage = "The gcwnet command line interface"
}

func main() {
	if err := app.Run(os.Args); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
func gcwnet(ctx *cli.Context) error {
	return nil
}
