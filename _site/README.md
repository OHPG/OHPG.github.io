# OHPG.github.io
OHPG Pages

## 本地预览

本项目使用 Jekyll 构建，提供了简化脚本来快速设置和启动本地预览。

### 🚀 快速开始（推荐）

#### 方法1：使用简化脚本

```bash
# 1. 设置环境（首次运行）
./setup.sh

# 2. 启动本地服务器
./start.sh
```

#### 方法2：手动配置

##### 1. 安装 Ruby 环境（使用 rbenv）

```bash
# 安装 rbenv
brew install rbenv

# 安装 ruby-build（用于编译 Ruby）
brew install ruby-build

# 初始化 rbenv
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc

# 安装 Ruby 3.3.0
rbenv install 3.3.0

# 设置为全局版本
rbenv global 3.3.0

# 验证安装
ruby -v
```

##### 2. 安装 Jekyll 和 Bundler

```bash
# 安装 Jekyll 和 Bundler
gem install jekyll bundler

# 验证安装
jekyll -v
```

##### 3. 项目启动

```bash
# 进入项目目录
cd /Users/wangx/sync-nas/OHPG.github.io

# 安装项目依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve
```

### 访问预览

启动成功后，在浏览器中访问：
- 本地地址：http://localhost:4000
- 或者：http://127.0.0.1:4000

### 📜 脚本说明

#### setup.sh - 环境设置脚本

自动完成以下任务：
- 检查并安装 Homebrew（如未安装）
- 安装 rbenv 和 ruby-build
- 初始化 rbenv 环境
- 安装 Ruby 3.3.0
- 安装 Jekyll 和 Bundler
- 安装项目依赖

**使用方法**：
```bash
# 首次设置环境
./setup.sh
```

#### start.sh - 服务器启动脚本

自动完成以下任务：
- 确保使用正确的 Ruby 版本
- 检查并安装依赖（如首次运行）
- 启动 Jekyll 本地服务器
- 启用文件监听和实时重载

**使用方法**：
```bash
# 启动本地服务器
./start.sh
```

**脚本参数**：
- `--open-url`：自动打开浏览器
- `--watch`：监听文件变化自动重建
- `--livereload`：启用实时重载

### 常用命令

```bash
# 重新构建站点
bundle exec jekyll build

# 清理生成的文件
bundle exec jekyll clean

# 启动服务器并自动打开浏览器
bundle exec jekyll serve --open-url

# 监听文件变化并自动重建
bundle exec jekyll serve --watch
```

### 注意事项

1. 确保使用 rbenv 管理的 Ruby 版本（3.3.0）
2. 如果遇到权限问题，请确认 rbenv 已正确初始化
3. 首次启动可能需要一些时间下载依赖
4. 修改文件后会自动重新构建（如果使用了 --watch 选项）
