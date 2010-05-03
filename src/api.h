#ifndef T3_SHARED_API_H
#define T3_SHARED_API_H

#if defined _WIN32 || defined __CYGWIN__
	#define T3_SHARED_EXPORT __declspec(dllexport)
	#define T3_SHARED_IMPORT __declspec(dllimport)
	#define T3_SHARED_LOCAL
#else
	#if __GNUC__ >= 4
		#define T3_SHARED_EXPORT __attribute__((visibility("default")))
		#define T3_SHARED_IMPORT __attribute__((visibility("default")))
		#define T3_SHARED_LOCAL __attribute__((visibility("hidden")))
	#else
		#define T3_SHARED_EXPORT
		#define T3_SHARED_IMPORT
		#define T3_SHARED_LOCAL
	#endif
#endif

#ifdef T3_IS_DSO
	#ifdef T3_BUILD_DSO
		#define T3_SHARED_API T3_SHARED_EXPORT
	#else
		#define T3_SHARED_API T3_SHARED_IMPORT
	#endif
	#define T3_SHARED_STATIC T3_SHARED_LOCAL
#else
	#define T3_SHARED_API
	#define T3_SHARED_STATIC
#endif

#endif
