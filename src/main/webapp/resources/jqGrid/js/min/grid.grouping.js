!function(o){"use strict";"function"==typeof define&&define.amd?define(["jquery","./grid.base"],o):"object"==typeof module&&module.exports?module.exports=function(r, e){return r||(r=window),void 0===e&&(e="undefined"!=typeof window?require("jquery"):require("jquery")(r)),require("./grid.base"),o(e),e}:o(jQuery)}(function(D){"use strict";var P=D.jgrid,_=D.fn.jqGrid;P.extend({groupingSetup:function(){return this.each(function(){var r,e,o,i,t,n=this,a=n.p,l=a.colModel,u=a.groupingView,s=function(){return""};if(null===u||"object"!=typeof u&&!D.isFunction(u))a.grouping=!1;else if(u.groupField.length){for(void 0===u.visibiltyOnNextGrouping&&(u.visibiltyOnNextGrouping=[]),u.lastvalues=[],u._locgr||(u.groups=[]),u.counters=[],r=0; r<u.groupField.length; r++)u.groupOrder[r]||(u.groupOrder[r]="asc"),u.groupText[r]||(u.groupText[r]="{0}"),"boolean"!=typeof u.groupColumnShow[r]&&(u.groupColumnShow[r]=!0),"boolean"!=typeof u.groupSummary[r]&&(u.groupSummary[r]=!1),u.groupSummaryPos[r]||(u.groupSummaryPos[r]="footer"),i=l[a.iColByName[u.groupField[r]]],!0===u.groupColumnShow[r]?(u.visibiltyOnNextGrouping[r]=!0,null!=i&&!0===i.hidden&&_.showCol.call(D(n),u.groupField[r])):(u.visibiltyOnNextGrouping[r]=D("#"+P.jqID(a.id+"_"+u.groupField[r])).is(":visible"),null!=i&&!0!==i.hidden&&_.hideCol.call(D(n),u.groupField[r]));for(u.summary=[],u.hideFirstGroupCol&&(u.formatDisplayField[0]=function(r){return r}),e=0,o=l.length; e<o; e++)i=l[e],u.hideFirstGroupCol&&(i.hidden||u.groupField[0]!==i.name||(i.formatter=s)),i.summaryType&&(t={nm:i.name,st:i.summaryType,v:"",sr:i.summaryRound,srt:i.summaryRoundType||"round"},i.summaryDivider&&(t.sd=i.summaryDivider,t.vd=""),u.summary.push(t))}else a.grouping=!1})},groupingPrepare:function(F, C){return this.each(function(){var r,e,o,i,t,n,a,l,u,s=this,d=s.p,p=d.groupingView,g=p.groups,m=p.counters,f=p.lastvalues,c=p.isInTheSameGroup,h=p.groupField.length,y=!1,v=_.groupingCalculations.handler,x=function(){var r,e,o;for(r=0; r<t.summary.length; r++)e=t.summary[r],o=D.isArray(e.st)?e.st[i.idx]:e.st,D.isFunction(o)?e.v=o.call(s,e.v,e.nm,F,i):(e.v=v.call(D(s),o,e.v,e.nm,e.sr,e.srt,F),"avg"===o.toLowerCase()&&e.sd&&(e.vd=v.call(D(s),o,e.vd,e.sd,e.sr,e.srt,F)));return t.summary},w=function(r, e){if(null==r&&p.useDefaultValuesOnGrouping){var o,i=void 0!==d.iColByName[e]?d.colModel[d.iColByName[e]]:d.additionalProperties[d.iPropByName[e]];null!=i&&null!=i.formatter&&(null!=i.formatoptions&&void 0!==i.formatoptions.defaultValue?r=i.formatoptions.defaultValue:"string"==typeof i.formatter&&void 0!==(o=D(s).jqGrid("getGridRes","formatter."+i.formatter+".defaultValue"))&&(r=o))}return r};for(r=0; r<h; r++)if(n=p.groupField[r],a=w(F[n],n),null==(u=null==(l=p.displayField[r])?null:w(F[l],l))&&(u=a),void 0!==a){for(o=[],e=0; e<=r; e++)o.push(F[p.groupField[e]]);for(i={idx:r,dataIndex:n,value:a,displayValue:u,startRow:C,cnt:1,keys:o,summary:[]},t={cnt:1,pos:g.length,summary:D.extend(!0,[],p.summary)},0===C?(g.push(i),f[r]=a,m[r]=t):"object"==typeof a||(D.isArray(c)&&D.isFunction(c[r])?c[r].call(s,f[r],a,r,p):f[r]===a)?y?(g.push(i),f[r]=a,m[r]=t):((t=m[r]).cnt+=1,g[t.pos].cnt=t.cnt):(g.push(i),f[r]=a,y=!0,m[r]=t),g[t.pos].summary=x(),e=t.pos-1; 0<=e; e--)if(g[e].idx<g[t.pos].idx){g[t.pos].parentGroupIndex=e,g[t.pos].parentGroup=g[e];break}}}),this},getGroupHeaderIndex:function(r, e){var o=this[0].p,i=e?D(e).closest("tr.jqgroup"):D("#"+P.jqID(r)),t=parseInt(i.data("jqgrouplevel"),10),n=o.id+"ghead_"+t+"_";return isNaN(t)||!i.hasClass("jqgroup")||r.length<=n.length?-1:parseInt(r.substring(n.length),10)},groupingToggle:function(c, h){return this.each(function(){var r,e,o,i=this,t=i.p,n=t.groupingView,a=n.minusicon,l=n.plusicon,u=h?D(h).closest("tr.jqgroup"):D("#"+P.jqID(c)),s=function(r){return r.find(">td>span.tree-wrap")},d=!0,p=!1,g=[],m=function(r){var e,o=r.length;for(e=0; e<o; e++)g.push(r[e])},f=parseInt(u.data("jqgrouplevel"),10);for(t.frozenColumns&&0<u.length&&(e=u[0].rowIndex,u=(u=D(i.rows[e])).add(i.grid.fbRows[e])),o=s(u),P.hasAllClasses(o,a)?(o.removeClass(a).addClass(l),p=!0):o.removeClass(l).addClass(a),u=u.next(); u.length; u=u.next())if(u.hasClass("jqfoot")){if(r=parseInt(u.data("jqfootlevel"),10),p){if(r=parseInt(u.data("jqfootlevel"),10),(!n.showSummaryOnHide&&r===f||f<r)&&m(u),r<f)break}else if((r===f||n.showSummaryOnHide&&r===f+1)&&m(u),r<=f)break}else if(u.hasClass("jqgroup"))if(r=parseInt(u.data("jqgrouplevel"),10),p){if(r<=f)break;m(u)}else{if(r<=f)break;r===f+1&&(s(u).removeClass(a).addClass(l),m(u)),d=!1}else(p||d)&&m(u);D(g).css("display",p?"none":""),t.frozenColumns&&D(i).triggerHandler("jqGridResetFrozenHeights",[{header:{resizeDiv:!1,resizedRows:{iRowStart:-1,iRowEnd:-1}},resizeFooter:!1,body:{resizeDiv:!0,resizedRows:{iRowStart:e,iRowEnd:u.length?u[0].rowIndex-1:-1}}}]),i.fixScrollOffsetAndhBoxPadding(),D(i).triggerHandler("jqGridGroupingClickGroup",[c,p]),D.isFunction(t.onClickGroup)&&t.onClickGroup.call(i,c,p)}),!1},groupingRender:function(v, x){var w="",C=this[0],j=C.p,F=0,b=[],q=j.groupingView,G=D.makeArray(q.groupSummary),S=q.groupField.length,R=q.groups,N=j.colModel,I=N.length,V=j.page,r="jqGridShowHideCol.groupingRender",e=function(r){return _.getGuiStyles.call(C,"gridRow",r)},O=e("jqgroup ui-row-"+j.direction),k=e("jqfoot ui-row-"+j.direction);function T(r, e, o, i, t){var n,a,l,u,s,d,p,g,m,f,c,h,y,v=R[r],x="",w=0,F=!0;if(0!==e&&0!==R[r].idx)for(n=r; 0<=n; n--)if(R[n].idx===R[r].idx-e){v=R[n];break}for(a=v.cnt,c=void 0===t?i:0; c<I; c++){for(l="&#160;",f=N[c],g=0; g<v.summary.length; g++)if(m=v.summary[g],h=D.isArray(m.st)?m.st[o.idx]:m.st,y=D.isArray(f.summaryTpl)?f.summaryTpl[o.idx]:f.summaryTpl||"{0}",m.nm===f.name){"string"==typeof h&&"avg"===h.toLowerCase()&&(m.sd&&m.vd?m.v=m.v/m.vd:m.v&&0<a&&(m.v=m.v/a));try{m.groupCount=v.cnt,m.groupIndex=v.dataIndex,m.groupValue=v.value,d=C.formatter("",m.v,c,m)}catch(r){d=m.v}l=P.format(y,d),f.summaryFormat&&(l=f.summaryFormat.call(C,o,l,d,f,m));break}s=u=!1,void 0!==t&&F&&(f.hidden||(l=t,F=!1,1<i&&(u=!0,w=i-1),s=f.align,f.align="rtl"===j.direction?"right":"left",q.iconColumnName=f.name)),p=!1,0<w&&!f.hidden&&"&#160;"===l?(p=!0,s&&(f.align=s),w--):(x+="<td role='gridcell' "+C.formatCol(c,1,"")+(u?"colspan='"+i+"'":"")+">"+l+"</td>",u=!1,s&&(f.align=s),p&&(f.hidden=!1,w--))}return x}return D.each(N,function(r, e){var o;for(o=0; o<S; o++)if(q.groupField[o]===e.name){b[o]=r;break}}),G.reverse(),D.each(R,function(r, e){var o,i,t,n,a,l,u,s,d=j.id+"ghead_"+e.idx,p=d+"_"+r,g=D.isFunction(q.groupCollapse)?q.groupCollapse.call(C,{group:e,rowid:p}):q.groupCollapse,m=1,f=0,c=S-1===e.idx,h=null!=e.parentGroup&&e.parentGroup.collapsed,y="<span style='cursor:pointer;margin-"+("rtl"===j.direction?"right:":"left:")+12*e.idx+"px;' class='"+q.commonIconClass+" "+(g?q.plusicon:q.minusicon)+" tree-wrap'></span>";if(q._locgr&&!(e.startRow+e.cnt>(V-1)*x&&e.startRow<V*x))return!0;h&&(g=!0),void 0!==g&&(e.collapsed=g),F++;try{o=D.isArray(q.formatDisplayField)&&D.isFunction(q.formatDisplayField[e.idx])?(e.displayValue=q.formatDisplayField[e.idx].call(C,e.displayValue,e.value,N[b[e.idx]],e.idx,e,r),e.displayValue):C.formatter(p,e.displayValue,b[e.idx],e.value,e)}catch(r){o=e.displayValue}if(w+="<tr id='"+p+"' data-jqgrouplevel='"+e.idx+"' "+(g&&h?"style='display:none;' ":"")+"role='row' class='"+O+" "+d+"'>","string"!=typeof(s=D.isFunction(q.groupText[e.idx])?q.groupText[e.idx].call(C,o,e.cnt,e.summary):P.template(q.groupText[e.idx],o,e.cnt,e.summary))&&"number"!=typeof s&&(s=o),"header"===q.groupSummaryPos[e.idx]?(m=1,"cb"!==N[0].name&&"cb"!==N[1].name||m++,"subgrid"!==N[0].name&&"subgrid"!==N[1].name||m++,w+=T(r,0,e,m,y+"<span class='cell-wrapper'>"+s+"</span>")):w+="<td role='gridcell' style='padding-left:"+12*e.idx+"px;' colspan='"+I+"'>"+y+s+"</td>",w+="</tr>",c){for(l=R[r+1],a=e.startRow,u=void 0!==l?l.startRow:R[r].startRow+R[r].cnt,q._locgr&&(f=(V-1)*x)>e.startRow&&(a=f),t=a; t<u&&v[t-f]; t++)w+=v[t-f].join("");if("header"!==q.groupSummaryPos[e.idx]){if(void 0!==l){for(i=0; i<q.groupField.length&&l.dataIndex!==q.groupField[i]; i++);F=q.groupField.length-i}for(n=0; n<F; n++)G[n]&&(w+="<tr data-jqfootlevel='"+(e.idx-n)+(g&&(0<e.idx-n||!q.showSummaryOnHide)?"' style='display:none;'":"'")+" role='row' class='"+k+"'>",w+=T(r,n,R[e.idx-n],0),w+="</tr>");F=i}}}),this.off(r).on(r,function(){var r,e,o,i,t=j.iColByName[q.iconColumnName];if(0<=D.inArray("header",q.groupSummaryPos)){for(i=0; i<N.length; i++)if(!N[i].hidden){o=i;break}if(void 0===o||t===o)return;for(r=0; r<C.rows.length; r++)e=C.rows[r],D(e).hasClass("jqgroup")&&(D(e.cells[o]).html(e.cells[t].innerHTML),D(e.cells[t]).html("&nbsp;"));q.iconColumnName=N[o].name}}),w},groupingGroupBy:function(t, n){return this.each(function(){var r,e,o=this.p,i=o.groupingView;for("string"==typeof t&&(t=[t]),o.grouping=!0,i._locgr=!1,void 0===i.visibiltyOnNextGrouping&&(i.visibiltyOnNextGrouping=[]),r=0; r<i.groupField.length; r++)e=o.colModel[o.iColByName[i.groupField[r]]],!i.groupColumnShow[r]&&i.visibiltyOnNextGrouping[r]&&null!=e&&!0===e.hidden&&_.showCol.call(D(this),i.groupField[r]);for(r=0; r<t.length; r++)i.visibiltyOnNextGrouping[r]=D(o.idSel+"_"+P.jqID(t[r])).is(":visible");o.groupingView=D.extend(o.groupingView,n||{}),i.groupField=t,D(this).trigger("reloadGrid")})},groupingRemove:function(t){return this.each(function(){var r,e=this.p,o=this.tBodies[0],i=e.groupingView;if(void 0===t&&(t=!0),!(e.grouping=!1)===t){for(r=0; r<i.groupField.length; r++)!i.groupColumnShow[r]&&i.visibiltyOnNextGrouping[r]&&_.showCol.call(D(this),i.groupField);D("tr.jqgroup, tr.jqfoot",o).remove(),D("tr.jqgrow",o).filter(":hidden").show()}else D(this).trigger("reloadGrid")})},groupingCalculations:{handler:function(r, e, o, i, t, n){var a,l,u={sum:function(){return parseFloat(e||0)+parseFloat(n[o]||0)},min:function(){return""===e?parseFloat(n[o]||0):Math.min(parseFloat(e),parseFloat(n[o]||0))},max:function(){return""===e?parseFloat(n[o]||0):Math.max(parseFloat(e),parseFloat(n[o]||0))},count:function(){return""===e&&(e=0),n.hasOwnProperty(o)?e+1:0},avg:function(){return u.sum()}};if(!u[r])throw"jqGrid Grouping No such method: "+r;return a=u[r](),null!=i&&(a="fixed"===t?a.toFixed(i):(l=Math.pow(10,i),Math.round(a*l)/l)),a}}})});
//# sourceMappingURL=grid.grouping.js.map