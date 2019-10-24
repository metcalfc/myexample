package main

import (
	"github.com/fatih/color"
)

var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func main() {
	color.Red("Hello World.")
	color.Blue("version: %s, commit: %s, date: %s", version, commit, date)
}
