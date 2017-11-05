
q=$1

if [ $2 = "explain" ]
then
  explain=true
else
  explain=false
fi
curl -XGET '192.168.33.14:9200/_search?explain='"$explain"'&pretty' -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "must": {
        "multi_match" : {
          "query" : "'"$q"'",
          "type": "cross_fields",
          "fields" : [ 
            "text.raw^3",
            "text.basic^2",
            "text.raw_ngramspe",
            "text.engram",
            "text.ngram",
            "text.engramspe",
            "text.ngramspe"
          ] 
        }        
      }  
    }
  }
}
'

# raw           => no tokenisation
# basic         => no tokenisation but lowercase, removed stopwords and asciifolding
# raw_ngramspe  => ??
# engram        =>
# ngram         =>
# engramspe     =>
# ngramspe      =>


# {
#   "query": {
#     "bool": {
#       "must": {
#         "multi_match" : {
#           "query" : "'"$q"'",
#           "type": "cross_fields",
#           "fields" : [ 
#             "text.raw",
#             "text.basic",
#             "text.raw_ngramspe",
#             "text.engram",
#             "text.ngram",
#             "text.engramspe",
#             "text.ngramspe"
#           ] 
#         }        
#       }  
#     }
#   }
# }
# '