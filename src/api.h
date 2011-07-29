/* Copyright (C) 2011 G.P. Halkes
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License version 3, as
   published by the Free Software Foundation.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
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

#ifdef T3_SHARED_BUILD_DSO
	#define T3_SHARED_API T3_SHARED_EXPORT
#else
	#define T3_SHARED_API T3_SHARED_IMPORT
#endif

#ifndef _T3_BOOL
#define _T3_BOOL
/** Boolean type that does not clash with C++ or C99 bool. @ingroup t3shared_other */
typedef enum {
	t3_false, /**< False */
	t3_true /**< True */
} t3_bool;
#endif

#endif
