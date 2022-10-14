# 一款ios swift项目
基本框架已通
现在在搭建其他的环境

有需求可以直接提issue


```
# 根据SwiftLint提示进行代码规范

1、 Vertical Whitespace Violation: Limit vertical whitespace to a single empty line. Currently 2.
空白问题，要求代码之间的空白行为一行，当前是2行或多行就会提示，修改的话删除多余空白行就可以

2、 Type Body Length Violation: Type body should span 200 lines or less excluding comments and whitespace: currently spans 325 lines
类的大小问题，当前要求一个类的大小是小于等于200行，不包括空白行和注释，当前是325行。修改这个很麻烦，只能进行类的拆分，但是有些类并不是越小越好，所以这条就根据当前类的自行考虑，并不一定需要照做

3、 Control Statement Violation: if, for, guard, switch, while, and catch statements shouldn't unnecessarily wrap their conditionals or arguments in parentheses.
当使用if、for、guard、switch、while、catch等语句时，并不需要加多余的括号

错误

if (plateNo.count > 1) {
    ...
}
正确

if plateNo.count > 1 {
    ...
}
4、 Opening Brace Spacing Violation: Opening braces should be preceded by a single space and on the same line as the declaration.
括号前应该空一格，而不是紧挨着语句，并且要求与声明在同一行

5、 Vertical Parameter Alignment Violation: Function parameters should be aligned vertically if they're in multiple lines in a declaration.
如果一个方法的参数分多行书写，则参数应该对齐

6、 Function Body Length Violation: Function body should span 40 lines or less excluding comments and whitespace: currently spans 48 lines
方法大小的问题，方法应该小于等于40行，不包括空白行和注释

7、 Colon Violation: Colons should be next to the identifier when specifying a type and next to the key in dictionary literals.
冒号违规问题，冒号应该靠左，并且右边有一个空格

let left:CGFloat = 90 错误

let left : CGFloat = 90 错误

let left: CGFloat = 90 正确

8、 Trailing Semicolon Violation: Lines should not have trailing semicolons.
swift在行的结尾处不应该有分号

let left: CGFloat = 90; 错误

let left: CGFloat = 90 正确

9、 File Line Length Violation: File should contain 400 lines or less: currently contains 496
文件应该小于等于400行

10、 Identifier Name Violation: Variable name should only contain alphanumeric characters: 'safe_bottom'
变量名不能包含除字母数字外的其他字符

public let safe_bottom: CGFloat错误

public let safeBottom: CGFloat正确

11、Identifier Name Violation: Variable name should be between 3 and 40 characters long: 'vc'
变量名定义应该在3-40个字符之间，用vc就只有2个字符，可以改为control等

12、 Force Cast Violation: Force casts should be avoided
避免直接的类型强转

let show = item as! Chemistry
错误

if let show = item as? Chemistry {

}
正确

13、 Unused Closure Parameter Violation: Unused parameter "model" in a closure should be replaced with _.
当参数并没有使用的时候，建议把参数名用_替代

14、 Mark Violation: MARK comment should be in valid format. e.g. '// MARK: ...' or '// MARK: - ...'
注释的格式错误，//和MARK中间需要有空格

15、 Comma Spacing Violation: There should be no space before and one after any comma.
逗号格式违规，逗号应该紧跟字符，不要有空格，逗号后空一格

16、 Trailing Newline Violation: Files should have a single trailing newline.
文件的结尾应该有一个空行

17、 Opening Brace Spacing Violation: Opening braces should be preceded by a single space and on the same line as the declaration.
左大括号间距违规：左大括号前面应该有一个空格，并与声明在同一行

18、 Implicit Getter Violation: Computed read-only properties should avoid using the get keyword
计算的只读属性应避免使用 get 关键字

19、 For Where Violation: where clauses are preferred over a single if inside a for
在for循环语句中，如果你的判断语句只有一句，应该使用where而不是if

20、 Multiple Closures with Trailing Closure Violation: Trailing closure syntax should not be used when passing more than one closure argument.
当函数有多个闭包的时候，最后不要使用尾随闭包，但是这个是一个非常恶心的提示，因为你用xcode的时候，xcode会自动帮你用尾随闭包，所以想不出现就需要自己手动改，很影响开发效率

foo.something(param1: { $0 }) { $0 + 1 } 错误

foo.something(param1: { $0 }, param2: {$0 + 1})
正确

21、 Weak Delegate Violation: Delegates should be weak to avoid reference cycles.
代理应该添加weak修饰符，避免循环引用

```


