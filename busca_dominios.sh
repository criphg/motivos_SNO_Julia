
#remover quebra de linha das sequencias
cat $1 | awk '{if ($0 ~ "^>") print"\n"$0; else printf("%s", $0)}' | tail -n +2 > seq_temp;

#busca pelo motivo.
grep -B 1 "[I|L].C..[D|E]" seq_temp > $1".out"
rm -f seq_temp;

sed -i '/^--$/d' $1".out";


#Arquivo Tabulado
cat $1".out" | awk '{if ($0 ~ "^>") printf("%s", $0); else print"|"$0}' > seq_temp;
echo -e "TriTrypID\tGenome_Name\tProtein_NAME\tType\tseq_Length\tseq" > $1".tab";
cat seq_temp |  awk '{gsub("  \| ","|");print }'| awk -F "|" ' function GSUB(F) {gsub (" ", "", $F)} BEGIN {OFS="\t"} {GSUB(1); GSUB(3); GSUB(4);GSUB(5);GSUB(6); gsub(">", "", $1); gsub("length=","",$5); gsub("^\s\s|\s\s$","",$2); print}' >> $1".tab";

rm -f seq_temp;
