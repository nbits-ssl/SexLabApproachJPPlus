﻿SexLab Approach JPPlus
====================================================================================

SexLab Approach 28-4-2014 v3がなかなかアプローチしてくれなかったので、原作者の許可を
とって改変、日本語化したものです。
性欲値や周囲の状況などを元に、NPCからPCに対してセックス、キス、ハグの3種類の提案を声
掛けされます。また、元々のModにはなかったNPCからNPCへの提案も発生します。
各種の動作は制御用のアイテムやMCMの設定を通して、対象や頻度などを変更することができ
ます。


## 概要

* PCの周囲を一定間隔でスキャンして、該当するNPCがいたら動作させます。
* 発生確率は下記などを元に変動します。(戦闘中は発生しません)
  * MCMの設定値
  * relationshiprank
  * ゲーム内時間
  * 周囲の明るさ
  * 周囲にベッドがあるかどうか
  * 裸かどうか

* 声掛けがめんどくさい場合はキャンセルでダイアログをキャンセルできます。
* レッサーパワー SLApproachToggle で動作を一時的にON/OFFできます。


## 注意事項

* 「場所を移そうか」は時間制限はありませんが、エリアチェンジをすると終了します。
* 「証」以外は装備している時のみ有効なので、強制脱衣やフォロワーから外れた場合は効果が
  発生しなくなります。 

* AmazingFollowerTweaksはシセロのダンスモーションを改変しているため、そのモーションを
  流用しているハグ時のアイドルがおかしくなります。シセロのモーションを改変しないファ
  イルがAFT側にあるので、それをインストールしてください。


## 既知の問題

* NPC⇔NPCの時の断る場合は、MCMの「倍率」設定値は機能しません(クエストオプションのポイ
  ント増減は機能します)。

* 声掛けをキャンセルで終了させて無視すると、しつこくもう一回聞かれることがあります。
* NPC⇔NPCで、まれに声掛けをしないでそのまま行為になることがあります。
* キスで絶頂しても性欲は解消されてしまいます（将来的には直したい）。
* たまにハグモーションが出ません。


## 必須

* Skyrim LE or SE
* Skyrim SexLab 1.62 or 1.63
* SexLab Aroused Redux


## 制御用アイテム一覧

MCMから取得することができます。インゲームのアイテムの説明欄にも記載しているので、とり
あえず全部取得してみるのもありです。スロットはxEditなどで変更しても構いません。

* Ｘの絆       ＝ スロット59・同じ絆を装備している者にしか声掛けしない・されない

* 恥じらいの心 ＝ スロット58・自分からは声掛けしない（声掛けはされる）
* 奉仕の心     ＝ スロット60・声掛けをされたら断らない
* 性奴隷の心   ＝ スロット60・同上(「奉仕の心」との違いは名前だけです)
* 獣の心       ＝ スロット58・断られたら必ずレイプする（PC相手でも有効）
* 博愛の心     ＝ スロット48・自分の「絆」を無視して声をかけられる・かける
* 人見知りの心 ＝ スロット59・TeammateかPC同士だけ声掛けする・される

* 両性愛の心   ＝ スロット57
　　　　　　　　　・PC装備  → 同性NPCから「も」声をかけられる
　　　　　　　　　・NPC装備 → 装備している者同士、声掛けしあう。
                  ※ 実装の都合上、この装備をしているNPCは声掛け頻度がやや低下する。

* 同性愛の心   ＝ スロット57
　　　　　　　　　・PC装備  → 同性NPCから「のみ」声をかけられる
　　　　　　　　　・NPC装備 → 効果なし

* 婚約の証     ＝ スロットなし・「所持」しているNPCはPC以外に声掛けしない・されない
* 家族の証     ＝ スロットなし・「所持」しているNPCは全く声掛けしない・されない

* 約束の証     ＝ スロットなし・「所持」しているNPCは全く声掛けしない・されない
                  ただし同じ「絆」を装備または「約束の証＋絆」を所持している者には声
                  掛けする・される

                  ※ 負荷が大きいアイテムなので、多用しないこと。
                  ※ MCMの「絆」設定の影響を受ける。
                  ※ 絆とペアにしない場合「家族の証」を使用すること。


## ダイアログ種別の説明

声掛けの台詞は主にVoiceTypeによって異なります。
オリジナルのVoiceTypeのフォロワーなどは「該当しないVoiceType」と判定され、YoungEagerと
同等の台詞になります。

* バニラの結婚ダイアログにならって、Neutral/Arrogant/Roughの3種類と、フォロワーに使われ
  ることが多いYoungYager、明確に口調や台詞が異なるMaleKajiit、Serena、Housecarlに分かれ、
  6パターン×男女で12タイプに分かれる
* DLC含むバニラのボイスタイプ(ユニーク含む)は「Childを除き」上記の12パターンのいずれか
  に分類済み

* ボキャブラリーの都合で、別のタイプでも同じ台詞が入っているところもある
* クリーチャーは特に拡充してない
* CKが落ちそうなので、これ以降の大幅な拡充の予定はなし


## アップグレード

特に注記がない限り、更新は上書きするだけです。


## アンインストール

スクリプトを使っているModなので、アンインストール後はセーブクリーナーなどでセーブデータ
の掃除をしてください。


## 謝辞

* Bethesda
* Skyrim SexLab & LoversLab

* ylenard (オリジナル作者)
* smashly (英訳＆アイテム追加ページ作者)

* bbspink Skyrim エロMod晒しスレ
* R18なModなので具体名は挙げませんが国内Modderの皆さま


## 更新履歴

### 2021-07-04

* 設定ファイルのセーブ・ロード機能を追加
* extended を参考に、MCMにアイテム追加ページを追加
* 負荷低減のため、PC戦闘中はループをスキップするように修正(リリース忘れ)

* readme.txtの書き直し
* 英語espの追加 (thank you, loverslab!)


### 2018-08-02

* 更新は単純に上書きでOK……たぶん
* NPC⇔NPCのハグやキスで、相手の状態を気にせずアクションを実行していたのを修正
* チェック方式をFactionからKeywordに切り替え


### 2018-06-14

* 更新は単純に上書きでOK……たぶん
* MCMが出なかった問題の修正


### 2018-06-08

* 更新は単純に上書きでOK……たぶん

* 「プレイヤーの現在の馬」、フロスト、シャドウメアからのアプローチ追加
  * ペットと同じ扱いで、PCとフォロワーにしかアプローチしません
  * PlayerHorseFactionに入っている、要はバニラで帰らずに留まる状態の馬が対象になります
　　Modの馬はそういう状態になってても、PlayerHorseFactionに入っていません
　　どうしても馬を変えたくない場合はコンソールから"addfac 68D78 0"で
  * フロストとシャドウメアは所有状態を見ていません（が、大きな問題はないと思います）
  * 馬の仕様の都合上、「ついてきて」などの選択肢はありません

  * Convenient Horsesのダブルタップ環境下でテストしています
  * 以前Immersive Horsesの環境下の馬関係で問題が出たことがあったので、今回も同様かもしれません
  * 問題があったらMCMから機能をオフにしてください
  * システム的にTeammateではありませんが、「人見知りの心」は突破してくるようにしています
  * 馬はアイテムを装備できないため、心や絆での制御ができません
　　女性フォロワーが襲われるのが嫌な場合はオフにしてください
  * 各Modなどで実現されている「フォロワーの馬」に対応するつもりはありません

* MCMにペット有効化と複数プレイの確率項目を追加

* ffレイプ時のアニメ選択と挙動を修正
* MCMの整理


### 2018-06-06

* 更新は単純に上書きでOK……たぶん

* ff/mm時のアニメ選択がfmも含めるようにしたはずが、なっていなかったのを修正
* fff/mmm時のアニメ選択も上記と同様に修正


### 2018-04-15

* 更新は単純に上書きでOK……たぶん、おそらく、きっと

* PCへの性的行為声掛け時「誰かを誘おう」選択肢で3Pまでできるように
  * システム的にはだいたい誰でも誘えます。自分で縛ってください
  * 男女犬、女犬犬、女リークリングリークリングとかができるように、クリーチャーも
　　誘えますが、アニメがない場合は再生されませんので誘う対象は気を付けてください
  * 「ついてきて」と同じく、エリアチェンジで声掛けモードは終了します
  * 気が変わったりしたら、声掛け元のNPCに声をかけてください

* 試験的にNPC間の3P実装
  * MCMの設定は色々効きません
  * 複雑なことはせずに「絆」などを持っているNPCは問答無用ではじいています
  * ペットが絡んだ3Pになることはありません
  * 「人見知りの心」だけはメインの2人のうちどちらかがフォロワーなら参加します
  * 性欲も見ておらず、声掛けNPCの出発点の近くに同性NPCがいたら、徒党をくんで迫り
　　ます。発生率は一律10%で、グローバル変数「SLApproachMultiplayPercent」で変更で
　　きます
　　テストする場合はコンソールで「set SLApproachMultiplayPercent to 100」

* 試験的にPCレイプ時の3P実装
  * NPC間の実装と大体同じです。使ってるグローバル変数も共通です
  * 声掛け元がフォロワーの場合、ヘルパーもフォロワーです、逆パターンもしかり
  * フォロワー以外のNPCからのレイプの場合、友好的なNPCはヘルパーにはなりません
  * 実装の都合上、徒党を組んでやってこれません、レイプが決まった時点でPCの近くにいる
　　NPCが使われます


* PC声掛けの台詞の種別が変わる性欲値の値をMCMから変更できるように。あわせてデフォルト
　を70から50に変更（前のバージョンからの更新の場合、70になってますので変更して下さい)
* NPC間のキス・ハグ時、声掛け側が近寄って一声発するように変更

* 3P対応のためアニメーション選択のコードを整理（同性愛とかに影響出るかも）
* 「どれにも該当しないVoicetype」の台詞がすべてのVoicetypeの台詞に入ってしまって
　いたのを修正
* キス・ハグの終了処理とエリアチェンジが重なった時にログを吐いていたのを再度修正
* ダイアログが開いているときでも終了処理が走っていた関係で、「ついてきて」の処理
　に不具合があったのを修正
* NPC間での「お断り」の数字がターゲットの性欲値を使っていなかったのを修正
* 性奴隷の心のアイテム名と説明がコピペに巻き込まれて家族の証になっていたのを修正
* 【悲報】奉仕/性奴隷の心、実装から全く動いていなかった【プラシーボ】修正


### 2018-04-01

* ニューゲームかSaveTool.exe経由での更新は必要ないはず
* ダイアログ関連のスクリプトを全部入れ替えたため、上書きでなく入れ替えを推奨
* ドーンガードが必須に

* 人型NPC→PCのダイアログの拡充
* ベッドのあるところではキスの確率を下げ、行為の確率を上げるように変更

* キス・ハグの終了処理が正常に走っていなかったのを修正
（そのせいで実害のないエラーログ吐いてたのもあわせて修正）
* PCへのキス声掛け時に、行為時の「PCと話しているNPCを横取りする行為の防止コード」が
　入っていたのを削除
* 「PCと話しているNPCを横取りする行為の防止コード」をキス・ハグ時にも適用するように
* NPC=>PCの際、一部指輪の効果が不具合を起こしていたのを修正
（人見知りの心・同性愛の心は確認)


### 2018-03-17

* 更新は単純に上書きでOK……たぶん

* 同性愛の心の名称を両性愛の心に変更
* 同性愛の心(PC Only)を追加
* 設定に「PCの最低性欲値」「NPCの最低性欲値」を追加

* キス時、SSLの設定にかかわらず脱衣アニメーション、ラグドールエンドをしないように
* MCMのCloakRangeの効果範囲上限を512に（Unitだと思っていたらftでした）
* MCMの「デフォルト」がさっぱり動いていなかった不具合を修正


### 2018-03-11

* スクリプトの整理をしているため、ニューゲームかSaveTool.exe経由の更新が必要。

* MCMから、各クエストの有効無効を切り替えられるように
* Relationship Rankの上下を返答の際に調整できるように。MCMからは廃止
* PCへの声掛けに周辺ベッドの有無が考慮されていなかったのを修正
* ダイアログの順番の調整
* リークリング対応（要DBになりました）

* PC/NPCともに、性行為の声掛けがしがたい状態の際、キス/ハグの声掛けをするように。
  * キス……周辺ベッドがない場合に
  * ハグ……上記に加えて、時間帯がふさわしくない時に
　※ 両者とも必要ない場合は-100してください。
　※ キスの備考（モーションはkissingタグがあり、sexタグがないものを使用・"Letio Kissing"など）

* コードの整理
※ 自環境では確認できていませんが、ハグモーションを利用するModで、モーション後ダメージが入る
　 ことがあるようなので、ご注意ください。モーション開始前に不死化、終了後に解除はしています。


### 2018-01-04

* 更新は単純に上書きでOK……たぶん。
* レイプ確率の増減設定をMCMに追加。
* PCへの同性声掛けを基本禁止に変更。同性愛の心をPCが持っている場合のみ、同性から声掛け
* 戦闘関係Mod動作中での誤動作を起こりにくくする対策コードを追加（完璧なものではない）
* MCMを少し修正


### 2017-12-29

* 更新は単純に上書きでOK……たぶん。
* MCMのl10nと設定の整理と詳細の追記（LLでMCMの意味がまるでわからねぇ！と言われていたので）
* マネキンとことに及んでいることがある問題を修正（Modの特殊なマネキンは未検証）
* 自分でも忘れるレベルなので、Readmeにアイテムの説明を整理して追加
* 「人見知りの心」がMCMの「絆」設定と連動していたのを修正
* 使わない場合の負荷削減のため、MCM「絆」設定のデフォルトを無効に変更
* 同性愛の心・婚約/家族/約束の証の追加

約束の証の正しい使い方
* 「絆」でカップリングしていた仲睦まじいフォロワーペアをフォロワーから外し、家を与える
* その家に寄った時でもPCや他のフォロワーに目移りしないで仲睦まじいままになる

約束の証の誤った使い方（めんどくさい上に負荷が高いので推奨するものではありません）
* カルロッタに約束の証と、何らかの絆を与える
* 夜にバナードメアに集まる男性諸君に約束の証と、↑とペアになる絆をばらまく
* ひゃっはー！未亡人は最高だぜ！家になんて帰さないぜ！
※ 実際にやってみましたが、残念ながらそうはなりませんでした。


### 2017-10-03

* 更新は単純に上書きでOK……たぶん。
* Immersive Horse環境下で起こる（？）、馬からの声掛けを修正。
* ペットからの声掛けで「楽しもう」の選択肢が出ていなかった不具合を修正。


### 2017-09-17

* スクリプトの整理をしているため、ニューゲームかSaveTool.exe経由の更新が必要。
* アクション毎のロックを厳密にしたので、NPC⇔NPCの発生率が落ちてる感じがするかも。

* ElderRaceを動作範囲に含めるかどうかのオプションを追加(デフォルトは含めない)。
* 以下のアイテムを追加。入手はAddItemMenuなどで。スロット変更可。名前変更可。

  * 人見知りの心　＝　スロット59・TeammateかPC同士だけ声掛けする・される
　※「絆」シリーズより優先度は低く、絆をつけている仲間には声掛けしない

* パッケージとシーンの見直し。
  * 声掛けの際にあんまり走り回らなくなったはず。
  * フォロワー拡張入れていない場合のフォロワーの声掛け動作の改善。
  * 使われていなかった残骸を削除。
* スクリプトの整理。
  * whistleクエストの残骸を削除。
* SexLabの性別設定の有効化(GetSex()をすべてSexLab.GetGender()に変更)。
  * 男だったら女にレイプされても男攻め女受けになっていたバグを修正。
  * 同性声掛けの場合、声をかけられた側が受け状態になるように変更。(受けpatch廃止)

* 死体となったNPCからの声掛け、死体への声掛けバグを修正。(Thanx! bbspinkスレ85の409)
* 「場所を移そう」で時間を気にせず引っ張りまわせるように。
* ↑のせいで長めにとっていたPC声掛けのタイムアウトを2分から30秒に変更。
* 「絆」シリーズ、「心」シリーズのアイテム説明欄に効果文章を記載。
* 自キャラへのレイプ判定に「獣の心」が反映されていないバグを修正。
* 男PCへのペットからの声掛けをしないように修正。
* ヴィジランスが人語を喋っていたのを修正(Creature Factionに入ってない……)。
* エリアチェンジを使っての声掛けはしないように修正(チェンジ時に声掛け停止)。
* 棒立ち現象の修正と、万が一棒立ちになってもSLApproachToggleで直せるように強化。
　「大人は嘘つきではないのです。間違いをするだけなのです」


### 2017-06-03

* 更新は単純に上書きでOK……たぶん。

* 機能を有効/無効でトグルするパワー「SLApproachToggle」追加
（クエストは止めないが、スクリプト遅延でデッドロックされた時の解除にも有効）
* 話している相手をNPC⇔NPCで横取りされる仕様を修正(要テスト・まだたまにされるようだ)
* 以下のアイテムを追加。入手はAddItemMenuなどで。スロット変更可。名前変更可。

  * 恥じらいの心　＝　スロット58・自分からは声掛けしない（声掛けはされる）
  * 奉仕の心　　　＝　スロット60・声掛けをされたら断らない
  * 性奴隷の心　　＝　スロット60・同上
  * 獣の心　　　　＝　スロット58・断られたら必ずレイプする（PC相手でも有効）
  * 博愛の心　　　＝　スロット48・自分の「絆」を無視して声をかけられる・かける
　※「絆」シリーズはスロット59

* ペットのアプローチ先をチームメイトとPCのみに変更。


### 2017-01-25

* 1021～1118のespに不具合があったため、一度でもセーブしてしまったら、以下が必要。

1. 今使ってるApproachを外してからSkyrimを立ち上げてセーブ
2. セーブツールなどでスクリプト除去(SaveTool.exeなら、FixScriptInstance)
3. 新版インストール

* 1021, 1118で追加したMCMの機能が全く動いていなかったのを修正。
* 死体へのアプローチに対して消極的防止コードの追加。


### 2016-11-18

* 更新は単純に上書きでOK。
* MCMにカップリングアクセサリON/OFF追加(デフォルトON)。
* MCMにNPC→PC時のrelationshiprank上下のON/OFF追加(デフォルトOFF)。
* NPC⇔NPCのペット絡みのシーンの最適化。
* プレイヤーレイプ計算式の見直し(ほぼ発生率と同じ計算式に)。
* NPC⇔NPCレイプの実装とMCMでのON/OFF(デフォルトON)
※ 上記２つの発生確率は声掛け計算式 / 10
* MCMに発生率に加算/減算できる数値の設定を追加。
※ 発生率は計算後の数値を0-100の範囲内にしてから、ランダムの0-100の数値と比較して
　 いるため、-100にすれば仕様上は発生しない、100にすれば仕様上は必ず声掛けになる。
 　Base chance multiplerは掛け算での調整。用途に合った方を。

* 発生率を全体的に下方修正する形で調整。


### 2016-10-21

* 更新は単純に上書きでOK。
* 10-15のパッケージングミス修正。
* MCMにPapyrusログ出力の欄追加。


### 2016-10-15

* 更新は単純に上書きでOK。初回ロード時はpapyrusログにwarning出る。セーブ＆ロードで
　なくなるはず。

* ペット対応。↓の通りなので男NPC⇔女NPCより発生率は低い。
  * ペットはAroused Creatureがあればarousalを、なければターゲットのarousalを使う。
  * ターゲットは女NPC限定。ペット→女NPCのみ。女NPC→ペットはない。
  * ドーンガードのハスキーとFLPの異種交信で仲間にしたクマでテスト済み。

* カップリング用アクセサリ(「～の絆」）の追加。
  * これを装備しているNPCは、同じ絆を装備している相手(PC含む)にしか声掛けしない。
  * これを装備しているPC/NPCは、同じ絆を装備している相手からしか声掛けされない。
  * パーティー全員に同じ絆を装備させると、パーティー間同士のみの声掛けになり、
　　一般NPCは一般NPCにしか声掛けしなくなる。
  * 他の誰も装備していない絆を装備しているPC/NPCは全く声掛けしなくなる/されなくなる。
  * 59番スロット。スロット変更可。名前変更可。入手はAddItemMenuかコンソールで。
　※ 内部的には声掛けしようとして諦めている処理になっているので、全体的な声掛け頻度は
　　 (アイテムを持ってる人間がいればいるほど/セルが多人数であればあるほど)下がる。

　　xx01b1b6　・　竜の絆
　　xx01b71a　・　炎の絆
　　xx01b71c　・　刃の絆
　　xx01b71d　・　血の絆
　　xx01b71e　・　風の絆　※ 名前による効果の変化はない。5ペアまで対応できるように5種。

* セラーナさんが漏れていたので、“パーティーメンバー”判定をCurrentFollowerFaction
　からチームメイト属性がついているか否かに変更。
* NPC⇔NPCの時にレイプモーションを弾くように変更。
* ペット対応含めてダイアログを更新、人間のも文章変更。SEQも更新。
* NPC⇔NPCの返事の際の計算式で反映されていなかった条件式を反映するように修正。
  * プレイヤーの行為時の＋－。
  * ターゲット(自分)が裸か否か。
* NPC→PCへの計算式一部変更(微妙に－方向に)

* スクリプトの中身整理。


### 2016-09-26

* プレイヤー以外対応のための構造変化のため、以下が必要。
　旧版アンインストール → セーブクリーナー → 新版インストール

* NPC⇔NPCに対応

* 発生率を左右するのは以下
  * Arousedの性欲値（基本コレ）
  * 1000Unit範囲にベッドがあるか（使えるかどうかは関係なし）
  * 時間（夜＋、昼－）
  * 明るさ
  * ターゲットが裸か否か
  * CurrentFollowerFactionに入っている者同士か否か
  * NPC⇔NPCは同性愛発生なし、PC相手は発生率低下
　※ relationshiprankは見てない。
　※ PCが行為中かどうか（行為中なら大幅＋）

  * NPC→PCも大体同じ基準。

* 何らかのシーン中のNPCは声掛けしないように変更
* 声かけが歩きだったのを小走りまで急ぐよう修正
　(フォロワーが声かけモードに入ると歩いてしまうためついてこれない)
* Whistleクエスト無効化(「かっこいいな！」とか「可愛いわね！」って言われるやつ)
* SEQファイル入れた。
* 翻訳少し修正。
* attraction外したせいで鬼のように出ていたerrorとかwarning全部消した。


### 2016-04-18

sexlab approach 28-4-2014 v3がなかなかアプローチしてくれなかったので
勝手に修正した版。日本語化済み。attraction不要。作者許諾済み。
言われるまで忘れてたけど、スタンドアロンフォロワーとかの追加種族からも
声をかけられるように修正済み。
