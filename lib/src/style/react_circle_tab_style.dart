/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

import 'package:badges/badges.dart' as b;

/// Convex shape is moved after selection.
class ReactCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  ReactCircleTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color activeIconColor,
    required Color badgeColor,
    required Color color,
    required Color textColor,
    required this.backgroundColor,
    required this.curve,
  }) : super(
            items: items,
            activeColor: activeColor,
            color: color,
            activeIconColor: activeIconColor,
            badgeColor: badgeColor,
            textColor: textColor);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    var margin = style.activeIconMargin;
    var textStyle = style.textStyle(textColor!, item.fontFamily);
    if (active) {
      final item = items[index];
      return TransitionContainer.scale(
        data: index,
        curve: curve,
        child: Column(
          children: [
            Container(
              // necessary otherwise the badge will not large enough
              width: style.layoutSize,
              height: style.layoutSize,
              margin: EdgeInsets.all(margin),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? activeColor : color,
              ),
              child: BlendImageIcon(
                active ? item.activeIcon ?? item.icon : item.icon,
                size: style.activeIconSize,
                color: item.blend ? activeIconColor : activeIconColor,
              ),
            ),
            Text(item.title!, style: textStyle)
          ],
        ),
      );
    }
    var children = <Widget>[
      item.isContainBadge!
          ? item.badgeCount != 0
              ? b.Badge(
                  position: b.BadgePosition.topEnd(top: -5, end: -7),
                  padding: item.badgeCount! > 9
                      ? EdgeInsets.all(3)
                      : EdgeInsets.all(5),
                  badgeColor: badgeColor!,
                  badgeContent: Text(
                    '${item.badgeCount}',
                    style: TextStyle(color: activeColor, fontSize: 11),
                  ),
                  child: BlendImageIcon(
                    active ? item.activeIcon ?? item.icon : item.icon,
                    color: item.blend ? activeColor : activeColor,
                  ),
                )
              : b.Badge(
                  position: b.BadgePosition.topEnd(top: -0.4, end: -0.1),
                  badgeColor: badgeColor!,
                  child: BlendImageIcon(
                    active ? item.activeIcon ?? item.icon : item.icon,
                    color: item.blend ? activeColor : activeColor,
                  ),
                )
          : BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? activeColor : activeColor,
            )
    ];

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
