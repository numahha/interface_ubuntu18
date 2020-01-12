# confinguration for custom kernel

bashスクリプトをローカルユーザとして実行する（途中で管理者権限を聞かれるのでその時にパスワードを入力）

## for ubuntu 18

* Security options  ---> [ ] Harden memory copies between kernel and userspace

つまり、[*] のチェックを外して [ ] にする。

## for RT-preempt

* General setup  ---> Preemption Model -> Fully Preemptible Kernel (RT)

## after changing configuration

save and exit

