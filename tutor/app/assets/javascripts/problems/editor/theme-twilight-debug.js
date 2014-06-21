// Source: Ace editor
// Integrated by: Rami Khalil
/* ***** BEGIN LICENSE BLOCK *****
 * Distributed under the BSD license:
 *
 * Copyright (c) 2010, Ajax.org B.V.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of Ajax.org B.V. nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL AJAX.ORG B.V. BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * ***** END LICENSE BLOCK ***** */

ace.define('ace/theme/twilight-debug', ['require', 'exports', 'module' , 'ace/lib/dom'], function(require, exports, module) {

exports.isDark = true;
exports.cssClass = "ace-twilight-debug";
exports.cssText = ".ace-twilight-debug .ace_gutter {\
background: #232323;\
color: #E2E2E2\
}\
.ace-twilight-debug .ace_print-margin {\
width: 1px;\
background: #232323\
}\
.ace-twilight-debug {\
background-color: #141414;\
color: #F8F8F8\
}\
.ace-twilight-debug .ace_cursor {\
color: #A7A7A7\
}\
.ace-twilight-debug .ace_marker-layer .ace_selection {\
background: rgba(221, 240, 255, 0.20)\
}\
.ace-twilight-debug.ace_multiselect .ace_selection.ace_start {\
box-shadow: 0 0 3px 0px #141414;\
border-radius: 2px\
}\
.ace-twilight-debug .ace_marker-layer .ace_step {\
background: rgb(102, 82, 0)\
}\
.ace-twilight-debug .ace_marker-layer .ace_bracket {\
margin: -1px 0 0 -1px;\
border: 1px solid rgba(255, 255, 255, 0.25)\
}\
.ace-twilight-debug .ace_marker-layer .ace_active-line {\
background: rgba(255, 0, 0, 0.231)\
}\
.ace-twilight-debug .ace_gutter-active-line {\
background-color: rgba(255, 0, 0, 0.231)\
}\
.ace-twilight-debug .ace_marker-layer .ace_selected-word {\
border: 1px solid rgba(221, 240, 255, 0.20)\
}\
.ace-twilight-debug .ace_invisible {\
color: rgba(255, 255, 255, 0.25)\
}\
.ace-twilight-debug .ace_keyword,\
.ace-twilight-debug .ace_meta {\
color: #CDA869\
}\
.ace-twilight-debug .ace_constant,\
.ace-twilight-debug .ace_constant.ace_character,\
.ace-twilight-debug .ace_constant.ace_character.ace_escape,\
.ace-twilight-debug .ace_constant.ace_other,\
.ace-twilight-debug .ace_heading,\
.ace-twilight-debug .ace_markup.ace_heading,\
.ace-twilight-debug .ace_support.ace_constant {\
color: #CF6A4C\
}\
.ace-twilight-debug .ace_invalid.ace_illegal {\
color: #F8F8F8;\
background-color: rgba(86, 45, 86, 0.75)\
}\
.ace-twilight-debug .ace_invalid.ace_deprecated {\
text-decoration: underline;\
font-style: italic;\
color: #D2A8A1\
}\
.ace-twilight-debug .ace_support {\
color: #9B859D\
}\
.ace-twilight-debug .ace_fold {\
background-color: #AC885B;\
border-color: #F8F8F8\
}\
.ace-twilight-debug .ace_support.ace_function {\
color: #DAD085\
}\
.ace-twilight-debug .ace_list,\
.ace-twilight-debug .ace_markup.ace_list,\
.ace-twilight-debug .ace_storage {\
color: #F9EE98\
}\
.ace-twilight-debug .ace_entity.ace_name.ace_function,\
.ace-twilight-debug .ace_meta.ace_tag,\
.ace-twilight-debug .ace_variable {\
color: #AC885B\
}\
.ace-twilight-debug .ace_string {\
color: #8F9D6A\
}\
.ace-twilight-debug .ace_string.ace_regexp {\
color: #E9C062\
}\
.ace-twilight-debug .ace_comment {\
font-style: italic;\
color: #5F5A60\
}\
.ace-twilight-debug .ace_variable {\
color: #7587A6\
}\
.ace-twilight-debug .ace_xml-pe {\
color: #494949\
}\
.ace-twilight-debug .ace_indent-guide {\
background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAACCAYAAACZgbYnAAAAEklEQVQImWMQERFpYLC1tf0PAAgOAnPnhxyiAAAAAElFTkSuQmCC) right repeat-y\
}";

var dom = require("../lib/dom");
dom.importCssString(exports.cssText, exports.cssClass);
});