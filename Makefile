CONFIG=Makefile.config

include $(CONFIG)

default: build

build:

	for file in \
		60_bloonix_check_linux_updates \
		60_bloonix_check_lsi_raid \
		60_bloonix_check_mdadm \
		60_bloonix_check_service \
		60_bloonix_check_smart_health \
		60_bloonix_check_gluster_status \
	; do \
		cp sudoers/$$file.in sudoers/$$file; \
		sed -i "s!@@PREFIX@@!$(PREFIX)!g" sudoers/$$file; \
	done;

install:
	if test ! -e "$(PREFIX)/lib/bloonix/plugins" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/plugins; \
		chmod 755 $(PREFIX)/lib/bloonix/plugins; \
	fi;

	cd plugins; for file in check-* ; do \
		cp $$file $(PREFIX)/lib/bloonix/plugins/; \
		chmod 755 $(PREFIX)/lib/bloonix/plugins/$$file; \
	done;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/plugins" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/plugins; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/plugins; \
	fi;

	cd plugins; for file in plugin-* ; do \
		cp $$file $(PREFIX)/lib/bloonix/etc/plugins/; \
		chmod 644 $(PREFIX)/lib/bloonix/etc/plugins/$$file; \
	done;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/sudoers.d" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/sudoers.d; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/sudoers.d; \
	fi;

	if test ! -e "$(PREFIX)/lib/bloonix/etc/conf.d" ; then \
		mkdir -p $(PREFIX)/lib/bloonix/etc/conf.d; \
		chmod 755 $(PREFIX)/lib/bloonix/etc/conf.d; \
	fi;

	for file in \
		check-linux-updates.conf \
		check-lsi-raid.conf \
		check-mdadm.conf \
		check-service.conf \
		check-smart-health.conf \
		check-gluster-status.conf \
	; do \
		cp -a sudoers/$$file $(PREFIX)/lib/bloonix/etc/conf.d/$$file; \
		chmod 644 $(PREFIX)/lib/bloonix/etc/conf.d/$$file; \
	done;

	for file in \
		60_bloonix_check_linux_updates \
		60_bloonix_check_lsi_raid \
		60_bloonix_check_mdadm \
		60_bloonix_check_service \
		60_bloonix_check_smart_health \
		60_bloonix_check_gluster_status \
	; do \
		cp -a sudoers/$$file $(PREFIX)/lib/bloonix/etc/sudoers.d/$$file; \
		chmod 644 $(PREFIX)/lib/bloonix/etc/sudoers.d/$$file; \
	done;

clean:
