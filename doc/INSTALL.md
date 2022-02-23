### Install and configure binaries

**Installation**
```
curl -s -L "https://github.com/loft-sh/vcluster/releases/latest" | sed -nE 's!.*"([^"]*vcluster-linux-amd64)".*!https://github.com\1!p' | xargs -n 1 curl -L -o vcluster && chmod +x vcluster;
sudo mv vcluster /usr/local/bin;
```

**Verify installation**
```
vcluster --version
```

**Bash completion**
```
cp ~/.bash_profile ~/.bash_profile_$(date +%F)
cat << EOF >> ~/.bash_profile
# Vcluster
. <(vcluster completion bash)
EOF
```