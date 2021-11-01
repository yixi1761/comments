def remoteConfig = [:]
remoteConfig.name = "my-remote-server"
remoteConfig.host = "${REMOTE_HOST}"
remoteConfig.port = 2222
// remoteConfig.port = "${REMOTE_PORT}"
remoteConfig.allowAnyHosts = true

node {
  // 使用当前项目下的凭据管理中的 SSH 私钥 凭据
  withCredentials([sshUserPrivateKey(
    credentialsId: "${REMOTE_CRED}",
    keyFileVariable: "privateKeyFilePath"
  )]) {

    // SSH 登陆用户名
    remoteConfig.user = "${REMOTE_USER_NAME}"
    // SSH 私钥文件地址
    remoteConfig.identityFile = privateKeyFilePath

    stage('生成ssh key,用于gitee或者github认证，clone两个仓库，只需执行一次') {
          // sh 'cd ~/.ssh && ls'
          // sh 'echo "" | ssh-keygen -t rsa -C admin@venuslight.site '
          // sh 'cd ~/.ssh && ls'
          // sh 'cat ~/.ssh/id_rsa.pub' 

          //添加git remote仓库，上面执行后再GitHub添加公钥再执行下面的关联
          //单独建winter仓库和winterpublic仓库，避免git冲突
          // sh 'git clone git@github.com:yixi1761/comments.git'
          // sh 'cd comments && git remote rename origin github && git remote add coding git@e.coding.net:justap/web/comments.git'
          // sh 'cd comments && git remote -v '
          sh 'cd comments && git pull coding master && git push github master'
          sh 'pwd && ls'
    }
    stage("使用upx登录又拍云，sync方式增量同步指定文件夹") {
        // 安装upx,二进制工具直接可用, put只执行一次
        // sh 'wget http://collection.b0.upaiyun.com/softwares/upx/upx_0.3.5_linux_x86_64.tar.gz && tar -zxvf upx_0.3.5_linux_x86_64.tar.gz'
        sh './upx login wpress some RGhN9k3TN7d3UCjq3IERerLtpOnAZMGA'
        sh './upx put winter /comments/winter'
        sh './upx put story /comments/story'
        sh './upx put img /comments/img'
        sh './upx put avatar /comments/avatar'
        sh './upx put JS /comments/JS'
        sh './upx logout'
    }
    stage("使用upx登录又拍云，sync方式增量同步指定文件夹") {
        // sync增量同步
        sh './upx login wpress some RGhN9k3TN7d3UCjq3IERerLtpOnAZMGA'
        sh './upx sync winter /comments/winter' -V
        sh './upx sync story /comments/story' -V
        sh './upx sync img /comments/img' -V
        sh './upx sync avatar /comments/avatar' -V
        sh './upx sync JS /comments/JS' -V
        sh './upx logout'
    }

    stage("通过 SSH 执行命令") {
        sshCommand(remote: remoteConfig, command: 'cd ~/git/comments && git pull coding master && git push github master')
        sshCommand(remote: remoteConfig, command: 'cd ~/git/wordpress && git pull coding master && git push github master')
    }
  }
}
