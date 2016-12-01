
//Swift String介绍
//1.string类型表示特定序列的字符值的集合

//1.初始化空字符串
var emptyString1 = ""
var emptyString2 = String()
var emptyString3 = "Jonkey"

if emptyString1.isEmpty {
    print("字符串为空")
}
if !emptyString3.isEmpty {
    print("字符串不为空")
}


//2.2.字符串比较、前缀、后缀、长度
let string1 = "string1"
let string2 = "string2"

//两个字符串是否相等
if string1 == string2 {
    print("相等")
} else {
    print("不相等")
}

//判断前缀是否存在
var name = "毒奶粉之地下城与勇士"
if name.hasPrefix("毒奶粉") {
    print("恭喜你，已经入坑")
}

//判断后缀是否存在
if name.hasSuffix("勇士") {
    print("垃圾勇士见上帝")
}

//判断是否包含字符串

// 判断字符串长度
let name2 = "诺克萨斯之手"
let name2Length = name.characters.count

// 遍历字符串
for character in name2.characters {
    print(character)
}

//3.字符串拼接
var gameName = "地下城之暗黑城"
let start = gameName.startIndex
let end = gameName.endIndex
let startCharacter = gameName[start]
//let endCharacter = gameName[gameName.endIndex]
let secondCharacter = gameName[gameName.startIndex]

//3.1插入
//指定下标插入字符
//gameName.insert("毒", at: gameName.startIndex)

//删除
//gameName.remove(at: gameName.startIndex)
//gameName.removeSubrange(gameName.startIndex..<gameName.startIndex)

//替换
//gameName.replaceRange(gameName.startIndex..<gameName.startIndex.advancedBy(2), with: "暗黑帝国")
