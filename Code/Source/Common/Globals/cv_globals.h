/* Copyright (c) 2009-2011 Open Source Medical Software Corporation,
 *                         University of California, San Diego.
 *
 * All rights reserved.
 *
 * Portions of the code Copyright (c) 1998-2007 Stanford University,
 * Charles Taylor, Nathan Wilson, Ken Wang.
 *
 * See SimVascular Acknowledgements file for additional
 * contributors to the source code.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "SimVascular.h"
#include "cv_arg.h"
#include "cv_misc_utils.h"
#include "cvRepository.h"
#ifdef USE_OPENCASCADE
//#include "TDocStd_Application.hxx"
//#include "AppStd_Application.hxx"
#include "XCAFApp_Application.hxx"
#endif

CV_GLOBALS_DLL_IMPORT cvRepository *gRepository;

#include "tcl.h"
CV_GLOBALS_DLL_IMPORT Tcl_HashTable gLsetVTable;
CV_GLOBALS_DLL_IMPORT Tcl_HashTable gLsetCoreTable;

CV_GLOBALS_DLL_IMPORT char projectionSetBase_[CV_STRLEN];

// global variable to figure out if we are running in batch mode
CV_GLOBALS_DLL_IMPORT int gSimVascularBatchMode;

CV_GLOBALS_DLL_IMPORT Tcl_Interp* gVtkTclInterp;
CV_GLOBALS_DLL_IMPORT Tcl_Interp* getTclInterp();
#ifdef USE_OPENCASCADE
//CV_GLOBALS_DLL_IMPORT AppStd_Application *gOCCTManager;
CV_GLOBALS_DLL_IMPORT Handle(XCAFApp_Application) gOCCTManager;
#endif
