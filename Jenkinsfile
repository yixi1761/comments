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

    stage("通过 SSH 执行命令") {
      sshCommand(remote: remoteConfig, command: 'cd ~/git/comments && git pull coding master && git push github master')
      sshCommand(remote: remoteConfig, command: 'cd ~/git/wordpress && git pull coding master && git push github master')
    }
  }
}
