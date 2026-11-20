#!/bin/bash

PORT="/dev/ttyACM0"
FILE="fluke.robot"

run_all() {
    python csv_test.py
    robot -v SERIAL_PORT:$PORT $FILE
}

run_random() {
   python random_csv.py
   robot -v SERIAL_PORT:$PORT $FILE
}

run_random2() {
   robot -v SERIAL_PORT:$PORT --randomize all $FILE 
}

run_low_hr() {
    robot -v SERIAL_PORT:$PORT "$FILE"
    rebot --exclude High --name "Low_HR_Report" --outputdir ./reports output.xml
}

case "$1" in
  all|"")
    echo "Running all tests"
    run_all
    ;;
    
  random)
    echo "Running tests in random order"
    run_random
    ;;

 rand)
    echo "Running tests in random order"
    run_random2
    ;;   
  lowhr)
    echo "Running tests with low heart rate filter"
    run_low_hr
    ;;
    
  *)
    echo "Usage: $0 [all|random|lowhr]"
    ;;
esac
