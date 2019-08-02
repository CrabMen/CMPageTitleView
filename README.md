![](https://github.com/CrabMen/CMResources/blob/master/CMPageTitleView/logo.png)

![](https://img.shields.io/cocoapods/v/CMPageTitleView.svg)
![](https://img.shields.io/cocoapods/p/CMPageTitleView.svg)
![](https://img.shields.io/apm/l/vim-mode.svg)

## 注意：目前0.5.1中布局的问题，已经紧急修复。同时也修复了本人在项目使用过程中，某些情况下CMPageTitleContentView的尺寸不准确的问题Pod版本更新到了0.5.2，建议依旧使用0.5.1版本的朋友，可以更新到0.5.2版本，以免影响用户体验。对您造成的不便，再次表示真诚的歉意!!!

* [效果展示](#screenshots)
  * [效果展示 - 基本样式](#screenshots-basic)
  * [效果展示 - 组合](#screenshots-multi)
* [安装](#installation)
* [示例](#example)
* [版本记录](#version)
* [支持](#support)
* [许可](#license)


## <a id="screenshots"></a>效果展示

### <a id="screenshots-basic"></a>效果展示 - 基本样式


| 基本样式    |    GIF|
| :-------- | --------:| 
|00-00.颜色效果 - RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_00.gif)|
|00-01.颜色效果 - 填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_01.gif)|
|00-02.颜色效果 - 无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_02.gif)|
|00-03.切换样式 - 字体放大 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_03.gif)|
|00-04.切换样式 - 下划线 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_04.gif)|
|00-05.切换样式 - 遮罩 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_05.gif)|
|00-06.切换样式 - 字体放大 - 延迟 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_06.gif)|
|00-07.切换样式 - 下划线 - 延迟 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_07.gif)|
|00-08.切换样式 - 遮罩 - 延迟 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_08.gif)|
|00-09.附加效果 - 标题栏下方分割线 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_09.gif)|
|00-10.附加效果 - 标题文字之间分割线 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_10.gif)|
|00-11.对齐方式 -- 左对齐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_11.gif)|
|00-12.对齐方式 -- 右对齐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_12.gif)|
|00-13.对齐方式 -- 居中 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_13.gif)|
|00-14.对齐方式 -- SpaceAround |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_14.gif)|
|00-15.字体放大效果时对其方式 -- 居中对齐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_15.gif)|
|00-16.字体放大效果时对其方式 -- 上对齐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_16.gif)|
|00-17.字体放大效果时对其方式 -- 下对齐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_00_17.gif)|



### <a id="screenshots-multi"></a>效果展示 - 组合样式

根据上方的基本样式可以进行自由组合，从而达到你想要的效果；因组合样式过多，下方列出了部分

| 组合样式    |    GIF|
| :-------- | --------:| 
|01-00.字体放大 - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_00.gif)|
|01-01.字体放大 - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_01.gif)|
|01-02.字体放大 - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_02.gif)|
|01-03.字体放大(延迟) - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_03.gif)|
|01-04.字体放大(延迟) - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_04.gif)|
|01-05.字体放大(延迟) - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_05.gif)|
|01-06.下划线 - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_06.gif)|
|01-07.下划线 - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_07.gif)|
|01-08.下划线 - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_08.gif)|
|01-09.下划线(延迟) - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_09.gif)|
|01-10.下划线(延迟) - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_10.gif)|
|01-11.下划线(延迟) - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_11.gif)|
|01-12.下划线（固定宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_12.gif)|
|01-13.下划线（固定宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_13.gif)|
|01-14.下划线（固定宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_14.gif)|
|01-15.下划线（延迟 && 固定宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_15.gif)|
|01-16.下划线（延迟 && 固定宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_16.gif)|
|01-17.下划线（延迟 && 固定宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_17.gif)|
|01-18.下划线（比例宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_18.gif)|
|01-19.下划线（比例宽度）- 颜色填充渐 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_19.gif)|
|01-20.下划线（比例宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_20.gif)|
|01-21.下划线（延迟 && 比例宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_21.gif)|
|01-22.下划线（延迟 && 比例宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_22.gif)|
|01-23.下划线（延迟 && 比例宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_23.gif)|
|01-24.下划线（延展）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_24.gif)|
|01-25.下划线（延展）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_25.gif)|
|01-26.下划线（延展）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_26.gif)|
|01-27.下划线（延展 && 固定宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_27.gif)|
|01-28.下划线（延展 && 固定宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_28.gif)|
|01-29.下划线（延展 && 固定宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_29.gif)|
|01-30.下划线（延展 && 比例宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_30.gif)|
|01-31.下划线（延展 && 比例宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_31.gif)|
|01-32.下划线（延展 && 比例宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_32.gif)|
|01-33.遮罩 - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_33.gif)|
|01-34.遮罩 - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_34.gif)|
|01-35.遮罩 - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_35.gif)|
|01-36.遮罩(延迟) - 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_36.gif)|
|01-37.遮罩(延迟) - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_37.gif)|
|01-38.遮罩(延迟) - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_38.gif)|
|01-39.遮罩（固定宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_39.gif)|
|01-40.遮罩（固定宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_40.gif)|
|01-41.遮罩（固定宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_41.gif)|
|01-42.遮罩（延迟 && 固定宽度）- 颜色RGB渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_42.gif)|
|01-43.遮罩（延迟 && 固定宽度）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_43.gif)|
|01-44.遮罩（延迟 && 固定宽度）- 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_44.gif)|
|01-45.字体放大 && 下划线 - 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_45.gif)|
|01-46.字体放大 && 下划线 && 延迟 - 颜色无渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_46.gif)|
|01-47.字体放大 && 下划线（延展）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_47.gif)|
|01-48.字体放大 && 下划线（延展 && 固定宽度 ）- 颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_48.gif)|
|01-49.字体放大 && 下划线（延展 && 比例宽度 ）-颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_49.gif)|
|01-50.字体放大 && 下划线（延展 && 放大时下对齐 ）-颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_50.gif)|
|01-51.字体放大 && 下划线（延展 && 放大时下对齐 && 左对齐）-颜色填充渐变 |![](https://raw.githubusercontent.com/CrabMen/CMResources/master/CMPageTitleView/CMPageTitleView_01_51.gif)|



## <a id="installation"></a>安装 

### CocoaPods安装:

* For iOS8+: 

```ruby
use_frameworks!
target '<Your Target Name>' do
    pod 'CMPageTitleView'
end
```

### 手动安装:
将 `CMPageTitleView/CMPageTitleView/Class` 路径下的所有文件拖拽到你的项目中. 


## <a id="example"></a>示例

首先, 先要导入.h头文件.

**如果cocoaposd安装:**
```
#import <CMPageTitleView/CMPageTitleView.h>
```
**如果手动安装:**

```
#import "CMPageTitleView.h"

```

创建CMPageTitleView 后，创建CMPageTitleConfig 对象并设置所需配置：

```
 CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:frame];
    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers; //必传参数
    
    [self.view addSubview:pageView];
```

同样支持Masonry布局，代码如下：

```
  CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    [self.view addSubview:pageView];
    
    [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CM_NAVI_BAR_H);
        make.height.mas_equalTo(CM_SCREEN_H - CM_NAVI_BAR_H);
        
    }];
    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig new];
    config.cm_childControllers = self.childControllers;//必传参数
    
    pageView.cm_config = config;

```

 按照上方代码，你已经创建了一个最简单的菜单栏🎉
 
**注意：**倘若需要复杂效果，可以通过创建CMPageTitleConfig对象中的 cm_gradientStyle（颜色渐变样式）、cm_switchMode（标题切换样式）、cm_additionalMode（附加效果）、cm_contentMode（对齐方式）、cm_scaleGradientContentMode（放大效果时的对齐样式）等基本样式的组合实现各种复杂效果，可以下载Demo查看具体效果，但是能实现的组合远远不止这些，更多组合可以集成到项目中尝试😊
 
## <a id="version"></a> 版本
* 2018-08-13 初始化项目 
* 2018-04-26 版本 0.3.0 新增 下划线比例宽度跟随标题文字宽度
* 2018-05-03 版本 0.3.1 cm_scale可以继续使用，新增cm_selectedFont属性，便于设置选中字体大小；支持**Masonry**
* 2018-05-09 版本 0.4.0 新增设置标题分割线Size以及Color功能；新增对外暴露的代理方法，便于用户做对应处理；新增断言异常提示；新增设置是否允许侧滑功能
* 2018-05-16 版本 0.4.1 修复cm_seperateLineHeight为0时无效的问题
* 2018-05-17 版本 0.4.2 新增cm_animationDruction属性，便于用户设置动画时间
* 2018-05-23 版本 0.5.0 新增cm_verticalContentMode，可以设置标题文字垂直方向的对齐方式；新增cm_additionalMode，便于设置分割线；优化cm_backgroundColor效果；优化相关代码调用时机
* ~~2018-07-13 版本 0.5.1 CMPageTitleView中新增-(void)cm_reloadConfig方法，便于用户刷新配置~~
* 2018-07-13 版本 0.5.2 CMPageTitleView中新增-(void)cm_reloadConfig方法，便于用户刷新配置；修复0.5.1中的布局bug；修复部分情况下CMPageTitleContentView对象尺寸不准确问题

## <a id="support"></a>支持
* 如果觉得该三方库还不错，可以[**★Star**](#)支持一下你的[**★Star**](#)就是我最大的动力
* 如果发现bug或想有其他的新功能，可以 **[issue](https://github.com/CrabMen/CMPageTitleView/issues)** 我

## <a id="license"></a>许可
CMPageTitleView 基于MIT许可

