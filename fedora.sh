#!/bin/bash



case "$1" in
	28)
         ./fedora28.sh
            ;;
	29)
         ./fedora29.sh
	    ;;
	33)
	 ./fedora33.sh
	    ;;
	uninstall)
          chmod +x ~/fedora-in-termux && chmod +x ~/fedora-in-termux/* && rm ~/fedora-in-termux -rf
            ;;
	*)
	    echo $"
 ________________________________
|                                |
|  Select version or uninstall:  |
|  28                            |
|  29
|  33
|  uninstall                     |
|________________________________|
"
	    exit 2
esac
