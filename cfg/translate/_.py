from requests import post
import sys

res = post("https://fanyi.baidu.com/sug", data={"kw": sys.argv[1]})
print(res.json())