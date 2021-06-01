```bash
sudo ufw allow 51276
sudo ufw allow 8581
```

https://www.reddit.com/r/homebridge/comments/i19ax0/accessory_is_not_reachable_when_trying_to_pair_to/

### then just add caddy subdomain entry

```bash
subdomain.tld.org {
    reverse_proxy localhost:$SOME_RANDOM_PORT_ON_VPS
}
```