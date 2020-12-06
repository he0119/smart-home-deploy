#!/bin/bash

################################
# 作用：PostgreSQL 备份脚本，备份 smart-home 数据库。
# 版本：1.0.1，2020-07-20
# 作者：www.typechodev.com modified by uy_sun
################################

backup_dir="$HOME/backups/smart-home"

function die(){
    test -z "$1" || echo "$1"
    exit 1
}

# 判断备份时间是否过频
min_time="43200" # 12小时
flag="/tmp/last_backup_smart-home"
last_backup="0"
test -f $flag && last_backup="`ls -l --time-style=+%s "$flag" | awk '{print $6}'`"
delta_time=$(expr "`date +%s`" - "$last_backup")

test "$delta_time" -lt "$min_time" && die "Time from last backup is less then $min_time, skip this time"

# 初始化环境
test -d "$backup_dir" || mkdir -p "$backup_dir" || die "Can not create backup dir"

# 备份数据库
sql_target="/tmp/smart-home.sql"
test -f "$sql_target" && rm "$sql_target"
sudo docker exec postgres pg_dump --exclude-table-data=iot_*data -U postgres smart-home > $sql_target
md5sum "$sql_target" > "$sql_target.md5sum"

# 打包
echo "Try to pack..."
backup_file="$backup_dir/smart-home.`date +%s`.tar.gz"
tar czvPf "$backup_file" "$sql_target" "$sql_target.md5sum"

# 清理临时文件
rm $sql_target
rm "$sql_target.md5sum"

touch "$flag"
echo "Backup to $backup_file done."
