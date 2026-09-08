#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 FILE"
    exit 1
fi

FILE="$1"

if [[ ! -f "${FILE}" ]]; then
    echo "Error: file ${FILE} not found"
    exit 1
fi

# 统计ERROR总行数
total_err=$(grep 'ERROR' -- "${FILE}" | wc -l)

# 只抓取 code= 后面的3位状态码
top_code=$(grep 'ERROR' -- "${FILE}" | grep -oE 'code=[0-9]{3}' | cut -d= -f2 | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')

echo "Total ERROR: ${total_err}"
echo "Top Code: ${top_code}"

exit 0

