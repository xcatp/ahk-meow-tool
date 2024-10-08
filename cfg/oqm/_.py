import execjs
import io
import sys
from requests import post
 
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='gb18030')  #改变标准输出的默认编码

with open('./_.js', 'r', encoding='utf-8') as f:
    jstext = f.read()
    
search_word = sys.argv[1]
 
ctx = execjs.compile(jstext)
sign = ctx.call('genSign', search_word)

res = post("http://www.xhup.club/Xhup/Search/searchCode", data={"search_word": search_word, "sign": sign})
print(res.json())