#!/bin/sh -e

COL='\033[0;34m'
NC='\033[0m' # No Color

for file in inputs/*.pdf; do
  printf "${COL}Stamping $file${NC}\n"

  filename=$(basename "$file")
  filename=${filename%%.pdf}
  pagecount=$(pdftk "$file" dump_data | grep NumberOfPages | sed 's/[^0-9]*//')
  pagecount=$((pagecount + 1))

  xelatex -interaction=batchmode "\def\attachmentName{$filename}\def\pageCount{$pagecount}\input{stamp}"
  pdftk "$file" multistamp stamp.pdf output "outputs/$filename.pdf"
  echo # newline
done
