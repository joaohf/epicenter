-record(epicenter_user, {username,
                         password_hash,
                         email,
                         validation_token = "",
                         roles = [],
                         remember_me_tokens = []}).

-define(REMEMBER_ME_TTL, 40320).  % four weeks