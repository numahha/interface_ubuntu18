# PREEMPT_RTの動作確認


## Modify Limits

Add limits of rtprio and memlock to /etc/security/limits.conf:
```
* - rtprio 99
* - memlock 1000000
```

## Sample

```
make
./test
```

