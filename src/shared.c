#include "shared.h"
#include "shared_errors.h"

#include <string.h>
#include <errno.h>

#ifndef T3_DEBUG
static int static_assert_version_not_0[T3_SHARED_VERSION > 0 ? 1 : -1];
#endif

#ifdef USE_GETTEXT
#include <libintl.h>
#define _(x) dgettext("LIBT3", (x))
#else
#define _(x) (x)
#endif

const char *t3_shared_strerror_base(int error) {
	switch (error) {
		case T3_ERR_SUCCESS:
			return _("success");
		case T3_ERR_ERRNO:
			return strerror(errno);
		case T3_ERR_EOF:
			return _("end of file");
		default: /* FALLTHROUGH */
		case T3_ERR_UNKNOWN:
			return _("unknown error");
		case T3_ERR_BAD_ARG:
			return _("bad argument passed to function");
		case T3_ERR_OUT_OF_MEMORY:
			return _("out of memory");
		case T3_ERR_TERMINFODB_NOT_FOUND:
			return _("no information found in terminfo database for terminal");
		case T3_ERR_HARDCOPY_TERMINAL:
			return _("terminal is a hard-copy terminal");
		case T3_ERR_TERMINAL_TOO_LIMITED:
			return _("terminal provides too limited functionality");
		case T3_ERR_NO_TERM:
			return _("no terminal given and TERM environment variable not set");
	}
}
