change_user () {
    HOST_UID=$(stat -c %u $PWD)
    HOST_GUID=$(stat -c %g $PWD)

    if [ ! "${HOST_UID}" = "$(id -u app)" ]; then
    	echo "HOST_UID: $HOST_UID"
	    echo "HOST_GUID: $HOST_GUID"

	    usermod -u $HOST_UID app
      groupmod -g $HOST_GUID app

      chown -R app:app /home/app
    fi
}

if [ -e /bundle/bundle.tar.gz ]; then
  cd /bundle
  change_user

else
  cd /built_app
  change_user
fi

if [[ $EUID -ne 0 ]]; then
	bash /home/app/scripts/start.sh
else
	su -c "bash /home/app/scripts/start.sh" app
fi
