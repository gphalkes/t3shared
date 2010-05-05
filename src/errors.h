#ifndef T3_SHARED_ERRORS_H
#define T3_SHARED_ERRORS_H

/** @file */
/** @addtogroup t3shared_other */
/** @{ */

/** @name Error codes (T3 generic) */
/*@{*/
#ifndef T3_ERR_SUCCESS
/** Error code: success */
#define T3_ERR_SUCCESS 0
/** Error code: see @c errno. */
/* Use large negative value, such that we don't have to number each and
   every value. */
#define T3_ERR_ERRNO (-128)
/** Error code: end of file reached. */
#define T3_ERR_EOF (-127)
/** Error code: unkown error. */
#define T3_ERR_UNKNOWN (-126)
/** Error code: bad argument. */
#define T3_ERR_BAD_ARG (-125)
/** Error code: out of memory. */
#define T3_ERR_OUT_OF_MEMORY (-124)
#endif
/*@}*/

/* Each extension of the list of common errors should be done with an ifdef
   such that when several different versions of the shared error header are
   included each symbol will be defined and only defined once. */

/** @} */

#endif
