#! /bin/bash

export PYTHON_VERSION=3.6.9

echo ""
echo "******************** Please confirm ***************************"
echo " Installing Python $PYTHON_VERSION may take a long time. "
echo " Select n to skip the installation or y to install it." 
read -p " Continue installing Python $PYTHON_VERSION (y/n) ? " CONTINUE
if [[ "$CONTINUE" == "y" || "$CONTINUE" == "Y" ]]; then
	echo "";
	echo "Installing Python $PYTHON_VERSION";
	echo "";
	echo "Downloading and Building the the Source Code";
	echo "";
	export PYTHON_DIR=$HOME/workspace/custom_builds
	export PYTHON_DOWNLOAD_URL=https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
	sudo apt update && sudo apt install -y \
		software-properties-common build-essential curl \
		libexpat1-dev libssl-dev zlib1g-dev \
		libncurses5-dev libbz2-dev liblzma-dev \
		dpkg-dev libreadline-dev libsqlite3-dev \
		libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
		python-minimal python3 python3-dev bluez libbluetooth-dev libboost-python-dev \
		python-tk python3-tk tk tk-dev
	
	mkdir -p $PYTHON_DIR
	wget "$PYTHON_DOWNLOAD_URL" -O python.tar.tgz
	tar -zxvf python.tar.tgz
	cd Python-$PYTHON_VERSION
	./configure --prefix=$PYTHON_DIR \
				--exec-prefix=$PYTHON_DIR \
				--enable-shared \
				--enable-profiling \
				--enable-optimizations \
				--enable-loadable-sqlite-extensions \
				--enable-ipv6 \
				--with-pydebug \
				--with-assertions \
				--with-lto \
				--with-system-expat \
  				--with-system-ffi \
				--with-threads
	make -j $(nproc)
	echo "";
	echo "Finalizing the Installation"
	echo "";
	sudo make altinstall -j $(nproc)
	
	echo "";
	echo "Updating pip3 to the latest version";
	echo "";
	sudo update-alternatives --install /usr/local/bin/python python $PYTHON_DIR/bin/python3.6 30
	sudo update-alternatives --install /usr/local/bin/python3 python3 $PYTHON_DIR/bin/python3.6 30
# 	echo 'export LD_LIBRARY_PATH=$PYTHON_DIR/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
	source ~/.bashrc
	sudo ldconfig
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	sudo python3 get-pip.py
else
	echo "";
	echo "Skipping Python $PYTHON_VERSION installation";
	echo "";
fi
