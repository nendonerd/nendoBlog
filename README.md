# What is it?
It's a blog deploy&cms system to automate plumber works and post my fancy hacks!

# Visit [my blog](https://nendo.co)

## Some thoughts
It's year 2018, I did not expect this hard to set up a simple blog.
It's like gluing a bunch of slippery stuff. There're lots of steps to make sure the glue is tight and tidy. So I guess this is what a web dev does -- putting things together and make it work. I wrote this  md and some bash scripts to record every step i did for gluing things. I hope you may set up your own ghost+isso blog system by follow my steps.

## Things I choose to use
stacks: docker, docker-compose, nginx, ghost, isso

Although wordpress is easy to use, but I'm not familiar with PHP. Instead I try to use it's modern nodejs alternative -- ghost. But ghost is not the subsitition of wordpress, it does not have many feature integrated, including comment system.
I don't like the idea of using a 3rd party comment system like Discord. They're usually slow to lauch, and who knows what they will do to your site. Weirdly, as for self-host comment systems, there are little choice.
Isso is one of them. But integrating Isso is really crazy, so I need to use docker to make ghost and isso work together, once and for all.


## Deploy in development ENV
```docker-compose -f docker-compose.dev.yml up --build```

## Deploy in production ENV

### 1. Manual steps before running the init.sh automated script: (for setting up vm/domain/dns)

 - 1. create a new vm on GCP

 - 2. set up ssh-key config:
        client$ `cat ~/.ssh/id_rsa.pub | pbcopy` , which will copy your client pubkey to clipboard. then you ssh to the server
        server$ `vim  ~/.ssh/authorized_keys`, which will create a new file, and paste the pubkey.
        GCP_console > metadata > ssh keys > paste your client pubkey into it
        mind for \n !!! ; And in both server and console, change pubkey's last field from client's username to server's username (you can check them by `echo $USER`)
        https://nabtron.com/gcc-mac-terminal/

 - 3. buy a domain at godaddy, and set the domain name server to (at domain management panel)
        asa.ns.cloudflare.com
        jerry.ns.cloudflare.com

 - 4. add site to cloudflare (for dns&cdn), in dns panel add record, then wait for dns update.
       once dns updated, in crypto panel turn off ssl, turn off automatic-https-rewrite

 - 5. apply for a SMTP key (for isso to work properly) in any mail service

### 2. Download and run init.sh
  server$
  ```
  wget
  sudo chmod 777 init.sh
  ./init.sh
  ```

### 3. Fill some environment variables in .env template
  server$
  ```
  cd nendoBlog/
  vim .env
  ```
  The stuff with asterisk(*) is things you must fill in. (fill the SMTP key in SMTP_PASSWORD field)

### 4. Start it up
  server$
  ```
  # cd into nendoBlog/
  sudo docker-compose -up --build
  ```

### 5. Turn on strict ssl policy
  Cloudflare -> crypto panel -> ssl: full; automatic-https-rewrite: true;


## How to Shutdown:
```docker-compose down```
or
```sudo docker-compose down```

## Todo List:
- [x] fix url issues
- [x] add https support
- [ ] make a vscode plugin to upload md files to ghost(should auto compress img and upload them too)
- [ ] create a mask for guiding wechat user to open in browser
- [ ] auto backup(sync) ghost/content & isso/db/comments.db to local
- [ ] learn handlebar and modify the theme
- [ ] auto add isso script to any scheme
- [ ] make a todo list tool for the blog
- [ ] make some logo
- [ ] rebuild a fully customized frontend using gatsby
