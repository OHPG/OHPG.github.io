#!/bin/bash

# OHPG.github.io 本地服务器启动脚本
# 一键启动 Jekyll 本地预览服务器

set -e

echo "🚀 启动 OHPG.github.io 本地服务器..."

# 确保使用正确的 Ruby 版本
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - bash)"
    rbenv shell 3.3.0
fi

# 检查依赖是否已安装
if [ ! -f "Gemfile.lock" ]; then
    echo "📦 首次运行，安装依赖..."
    bundle install
fi

# 启动 Jekyll 服务器
echo "🌐 启动本地服务器..."
echo "   地址: http://localhost:4000"
echo "   按 Ctrl+C 停止服务器"
echo ""

bundle exec jekyll serve --watch --livereload

# 捕获 Ctrl+C 信号，优雅退出
trap 'echo "\n👋 服务器已停止"; exit 0' SIGINT