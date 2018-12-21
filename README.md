# A blog to host my fancy hacks
stacks: docker, ghost, isso

## Usage

### Configure
```code .env```<br>
fill the build args specified in docker-compose.yml as key=value

```code ./ghost/content/themes/casper-xyz-master/post.hbs```<br>
change url in line 79 to be your own domain name

### Deploy
```docker-compose up -d```
### Shutdown
```docker-compose down```

It's year 2018, I did not expect this hard to set up a simple blog.
Although wordpress is easy to use, but I dipite PHP and don't want to learn it. Instead I try to use it's modern nodejs alternative -- ghost. But ghost is not the subsitition of wordpress, it does not have many feature integrated, including comment system.
I don't like the idea of using a 3rd party comment system like Discord. They're usually slow to lauch, and who knows what they will do to your site. Weirdly, as for self-host comment systems, there are little choice.
Isso is one of them. But integrating Isso is really crazy, so I need to use docker to make ghost and isso work together, once and for all.


## Todo List:
- fix url issues
- add https support
- auto backup(sync) ghost/content & isso/db/comments.db
- auto add isso script to any scheme
- make a todo list tool for the blog
- make some logo
- develop a proper theme
