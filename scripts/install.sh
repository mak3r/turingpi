#!/bin/sh 

while getopts 'mwn:s:t:pv:r' c
do
  case $c in
	m) MODE=MASTER ;;
	w) MODE=WORKER ;;
	S) MODE=SINGLE ;;
	n) NODE_NAME=$OPTARG ;;
	p) PREP="1" ;;
	r) REMOVE="1" ;;
	s) K3S_URL=$OPTARG ;;
	t) TOKEN=$OPTARG ;;
	v) VERSION=$OPTARG ;;
  esac
done

function install_master() {
	cat ./scripts/install-k3s-master.sh | ssh -o "StrictHostKeyChecking=no" $NODE_NAME "cat > /tmp/script ; chmod 755 /tmp/script ; sudo /tmp/script $TOKEN $VERSION"
}

function install_worker() {
	cat ./scripts/install-k3s-worker.sh | ssh -o "StrictHostKeyChecking=no" $NODE_NAME "cat > /tmp/script ; chmod 755 /tmp/script ; sudo /tmp/script $TOKEN $K3S_URL $VERSION"
}

function install_single() {
	cat ./scripts/install-k3s-single-node.sh | ssh -o "StrictHostKeyChecking=no" $NODE_NAME "cat > /tmp/script ; chmod 755 /tmp/script ; sudo /tmp/script $VERSION"
}

if [ "$PREP" == "1" ]; then
	cat ./scripts/raspbian-post-config.sh | ssh -o "StrictHostKeyChecking=no" $NODE_NAME "cat > /tmp/script ; chmod 755 /tmp/script ; sudo /tmp/script "
	ssh $NODE_NAME sudo reboot
	sleep 90
fi

if [ "$REMOVE" == "1" ]; then
	cat ./scripts/remove-k3s.sh | ssh -o "StrictHostKeyChecking=no" $NODE_NAME "cat > /tmp/script ; chmod 755 /tmp/script ; sudo /tmp/script"
fi

case $MODE in
	MASTER) install_master ;;
	WORKER) install_worker ;;
	SINGLE) install_single ;;
esac

