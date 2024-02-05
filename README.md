### すでに入っているパッケージは[こちら](https://hub.docker.com/layers/library/r-base/4.3.1/images/sha256-06979524919e444f50cf01c8e37403a90c7d06daf988c206c3236049f75fe3bd?context=explore)
R_VERSION=4.3.1

## dockerの立ち上げ方  
<ローカル>
### **1.Githubから必要なものをclone,またはダウンロードしてくる** 
```$ git clone git@github.com:ayakamori0702/R-docker``` 

ダウンロードする場合は、ほしいversionのtagからzipかtarをダウンロード

必要なスクリプトやデータがあれば、vis-toolsフォルダに追加
### **2.dockerfileをbuildする**  
```$ docker build -t amori/r-base:v0.0```  

確かめるとき
```$ docker images```

### **3.docker runする**  
```$ ./run.sh```  
このとき、run.shの **リポジトリ名:タグ名 またはイメージID** が合っているか確認する.
(最後の行がイメージIDでないとだめな場合もあり)

tokenは
```$ docker logs jupyter``` 
で確認