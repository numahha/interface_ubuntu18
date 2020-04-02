# 動作確認（Interface社ボード）

インタフェース社ドライバの中継ボックスとPCが繋がっていて、かつ中継ボックスに電源が供給されていることを確認すること。


## CNT
まずモジュールをロードする。
（GPG/GPH-6204でエンター→command number:99でエンター、とする）
```
cd /usr/src/interface/gpg6204/x86_64/linux/drivers
sudo bash inspenc.sh
sudo bash setup.sh
```
サンプルコードをコンパイル・実行する。数字が流れていけば成功。
```
cd /usr/src/interface/gpg6204/x86_64/linux/samples/c/simplecount
sudo make
sudo ./simplecount
```

## DA
まずモジュールをロードする。
（GPG/GPH-3300でエンター→command number:99でエンター、とする）
```
cd /usr/src/interface/gpg3300/x86_64/linux/drivers
sudo bash insda.sh
sudo bash setup.sh
```
Makefile内のCFLAGS = -lgpg3300をLDLIBS = -lgpg3300に変更する（このディレクトリのMakefile参照）。
```
cd /usr/src/interface/gpg3300/x86_64/linux/samples/c/DaOutputDA/
sudo gedit Makefile
```
サンプルコードをコンパイル・実行する。
```
cd /usr/src/interface/gpg3300/x86_64/linux/samples/c/DaOutputDA/
sudo make
sudo ./DaOutputDA
```
Enter the device number.:1でエンター、でプログラムが無事終わってくれれば成功。
