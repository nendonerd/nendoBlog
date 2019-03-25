#!/bin/sh
rsync -a root@193.110.202.159:/home/wang3721_2011/nendoBlog/ghost/content/ /Users/jack/Desktop/CS/projects/nendoBlog/ghost/content
rsync -a root@193.110.202.159:/home/wang3721_2011/nendoBlog/isso/db/ /Users/jack/Desktop/CS/projects/nendoBlog/isso/db
rsync -a /Users/jack/Desktop/CS/projects/nendoBlog/.env root@193.110.202.159:/home/wang3721_2011/nendoBlog/.env

# rsync -a /Users/jack/Desktop/CS/projects/nendoBlog/ghost/content/ wang3721_2011@34.92.170.49:/home/wang3721_2011/nendoBlog/ghost/content
# rsync -a /Users/jack/Desktop/CS/projects/nendoBlog/isso/db/ wang3721_2011@34.92.170.49:/home/wang3721_2011/nendoBlog//isso/db