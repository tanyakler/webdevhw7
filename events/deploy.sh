#!/bin/bash

export MIX_ENV=prod
export PORT=4798
export SECRET_KEY_BASE=W68eso5YQOlbtvSNUR50N/HDWj6laEhAwMR3LtzuBEQAefwYVbX84bvoTA7XtiGi
export DATABASE_URL=ecto://events:events1events2@localhost/events_dev

mix deps.get --only prod
mix compile

CFGD=$(readlink -f ~/.config/events)

if [ ! -d "$CFGD" ]; then
	mkdir -p "$CFGD"
fi

if [ ! -e "$CFGD/base" ]; then
	mix phx.gen.secret > "$CFGD/base"
fi

if [ ! -e "$CFGD/db_pass" ]; then
	pwgen 12 1 > "$CFGD/db_pass"
fi



SECRET_KEY_BASE=$(cat "$CFGD/base")

export SECRET_KEY_BASE

DB_PASS=$(cat "$CFGD/db_pass")
export DATABASE_URL=ecto://eventss:$DB_PASS@localhost/events_dev


mix ecto.migrate
exit

npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

mix release
