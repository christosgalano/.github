// package main
package main

import (
	"flag"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
)

func main() {
	mode := flag.String("mode", "", "Mode to run in")
	path := flag.String("path", "", "Path to list")

	flag.Parse()

	if *path == "" {
		panic("Path is required")
	}

	if *mode == "" {
		panic("Mode is required")
	}

	f, err := os.Stat(*path)
	if err != nil {
		panic(err)
	}

	switch *mode {
	case "scan":
		fmt.Println("Scanning...")
	case "update":
		fmt.Println("Updating...")
	default:
		panic("Invalid mode")
	}

	if f.IsDir() {
		err = filepath.WalkDir(f.Name(), func(path string, d fs.DirEntry, err error) error {
			if err != nil {
				panic(err)
			}
			if d.IsDir() {
				fmt.Printf("Directory: %s\n", d.Name())
			} else {
				fmt.Printf("File: %s\n", d.Name())
			}
			return nil
		})
	} else {
		fmt.Printf("File: %s\n", f.Name())
	}
}
