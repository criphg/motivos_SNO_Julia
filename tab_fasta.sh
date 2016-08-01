cat $1 | awk '{if ($0 ~ "^>") printf("%s", $0); else print"|"$0}' > seq_temp;
echo "TriTrypID\tGenome_Name\tProtein_NAME\tType\tseq_Length\tseq" > $1".tab";
cat seq_temp | awk -F "|" 'BEGIN {OFS="\t"} {gsub(">", "", $1); gsub("length=","",$5); print}' >> $1".tab";

