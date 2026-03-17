#!/bin/bash

# OHPG.github.io 本地预览设置脚本
# 简化环境配置和项目启动流程

set -e  # 遇到错误时退出

echo "🚀 开始设置 OHPG.github.io 本地预览环境..."

# 检查是否已安装 Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew 已安装"
fi

# 检查是否已安装 rbenv
if ! command -v rbenv &> /dev/null; then
    echo "📦 安装 rbenv..."
    brew install rbenv ruby-build
else
    echo "✅ rbenv 已安装"
fi

# 初始化 rbenv（如果尚未初始化）
if ! grep -q "rbenv init" ~/.zshrc; then
    echo "🔧 初始化 rbenv..."
    echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
    source ~/.zshrc
else
    echo "✅ rbenv 已初始化"
fi

# 检查 Ruby 版本
CURRENT_RUBY=$(ruby -v | awk '{print $2}' | cut -d. -f1-2)
if [[ "$CURRENT_RUBY" != "3.3" ]]; then
    echo "📦 安装 Ruby 3.3.0..."
    rbenv install 3.3.0 --skip-existing
    rbenv global 3.3.0
    # 重新加载环境
    eval "$(rbenv init - zsh)"
else
    echo "✅ Ruby 3.3.0 已安装"
fi

# 检查 Jekyll 是否已安装
if ! command -v jekyll &> /dev/null; then
    echo "📦 安装 Jekyll 和 Bundler..."
    gem install jekyll bundler
else
    echo "✅ Jekyll 已安装"
fi

echo "📦 安装项目依赖..."
bundle install

echo "🎉 环境设置完成！"
echo ""
echo "📝 使用以下命令启动本地服务器："
echo "   bundle exec jekyll serve"
echo ""
echo "🌐 访问 http://localhost:4000 预览网站"
echo ""
echo "💡 提示：可以使用以下参数："
echo "   --open-url    自动打开浏览器"
echo "   --watch       监听文件变化自动重建"
echo "   --livereload  启用实时重载"