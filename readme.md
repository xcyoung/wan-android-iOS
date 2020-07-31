项目架构参考：

https://github.com/manondidi/swiftArch

### 2020.06.26
- 添加Toast组件
  参考项目：
  
  https://github.com/devxoul/Toaster
  
  https://github.com/WangLiquan/EWToast
  
  https://github.com/Darren-chenchen/CLToast

- 集成Lottie, 对于Toast显示逻辑优化

### 2020.06.27
- 新增页面管理PageStateManager

- 引入SnapKit布局

### 2020.06.30

- 集成Alamofire，新增http请求封装

### 2020.07.05

- 加入UITableView在UIController的封装、分页逻辑、下拉刷新、上拉加载逻辑封装

- 加入XError用于错误信息统一处理

- 添加UIController的扩展对于toast的显示

### 2020.07.06

- 新增Repo、Service搭建项目数据层

- 新增HttpObserverType用于统一处理http请求回调结果

- 接入WanAndroidApi 文章列表、置顶文章接口：

    "article/list/\(pageIndex)/json"

    "article/top/json"

### 2020.07.14

- 引入MyLayout布局

- 文章列表TableViewCell ui

### 2020.07.31

- 简单完成文章列表，包括banner

- 简单完成browser

- 移除SnapKit