#!/bin/bash

# txtでもcsvでも描画可能
txtData=./data/data.txt
csvData=./data/data.csv


# 軸の補助線・グリッドを追加
img=./img/test1.ps
range=1/5/0/10
base=a1f1g1/a2f3g4
gmt psxy $txtData -R$range -B$base -Jx3/2 -P > $img
gmt ps2raster $img -Tg -E100

# タイトル・軸ラベル追加
img=./img/test2.ps
base=a1f1g1:"x"::."title":/a2f3g4:"y":
gmt psxy $txtData -R$range -B$base -Jx -P > $img
gmt ps2raster $img -Tg -E100

# タイトル・軸ラベル追加を左と下のみ
img=./img/test3.ps
base=a1f1g1:"x"::."title":/a2f3g4:"y":SWne
gmt psxy $txtData -R$range -B$base -Jx -P > $img
gmt ps2raster $img -Tg -E100


# 線の色を追加
img=./img/test4.ps
lineColor=0/128/0
gmt psxy $txtData -R$range -B$base -Jx -W1,$lineColor -P > $img
gmt ps2raster $img -Tg -E100

# ポイントに図形を追加
img=./img/test5.ps
circleColor=green
gmt psxy $txtData -R$range -B$base -Jx -W1,$lineColor -P -K > $img
gmt psxy $txtData -R -B -J -Sc0.2 -G$circleColor -O >> $img
gmt ps2raster $img -Tg -E100


# 軸を複数に変更
img=./img/test6.ps
data2Color=red
data2Range=1/5/0/100
data2Base=a1g1/a20f10:"y2":E
gmt psxy $txtData -R$range -B$base -Jx -W1,$lineColor -P -K > $img
gmt psxy $txtData -R -B -J -Sc0.2 -G$circleColor -K -O >> $img
gmt psxy $csvData -R$data2Range -B$data2Base -Jx1/0.1 -W1,$data2Color -K -O >> $img
gmt psxy $csvData -R -B -J -St0.2 -G$data2Color -O >> $img
gmt ps2raster $img -Tg -E100



# 凡例追加
img=./img/test7.ps
frameColor=0/0/255
backColor=#FFFFFF
legRange=1/9.5/1/1.2
gmt psxy $txtData -R$range -B$base -Jx -W1,$lineColor -P -K > $img
gmt psxy $txtData -R -B -J -Sc0.2 -G$circleColor -K -O >> $img
gmt psxy $csvData -R$data2Range -B$data2Base -Jx1/0.1 -W1,$data2Color -K -O >> $img
gmt psxy $csvData -R -B -J -St0.2 -G$data2Color -K -O >> $img
gmt pslegend -R -J -Dx$legRange -F+p1,blue+gwhite -O <<EOF >> $img
S 0 c 0.2 green black 0.2 y
S 0 t 0.2 red black 0.2 y2
EOF
gmt ps2raster $img -Tg -E100
