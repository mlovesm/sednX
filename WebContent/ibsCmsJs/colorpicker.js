! function (e) {
	$(this).css('z-index','5000');
	$(this).css('position','relative')
    var t = function (e) {
        this.value = {
            h: 1,
            s: 1,
            b: 1,
            a: 1
        }, this.setColor(e)
    };
    t.prototype = {
        constructor: t,
        setColor: function (t) {
            t = t.toLowerCase();
            var i = this;
            e.each(n.stringParsers, function (e, a) {
                var o = a.re.exec(t),
                    r = o && a.parse(o),
                    s = a.space || "rgba";
                return r ? (i.value = "hsla" === s ? n.RGBtoHSB.apply(null, n.HSLtoRGB.apply(null, r)) : n.RGBtoHSB.apply(null, r), !1) : void 0
            })
        },
        setHue: function (e) {
            this.value.h = 1 - e
        },
        setSaturation: function (e) {
            this.value.s = e
        },
        setLightness: function (e) {
            this.value.b = 1 - e
        },
        setAlpha: function (e) {
            this.value.a = parseInt(100 * (1 - e), 10) / 100
        },
        toRGB: function (e, t, i, n) {
            e || (e = this.value.h, t = this.value.s, i = this.value.b), e *= 360;
            var a, o, r, s, l;
            return e = e % 360 / 60, l = i * t, s = l * (1 - Math.abs(e % 2 - 1)), a = o = r = i - l, e = ~~e, a += [l, s, 0, 0, s, l][e], o += [s, l, l, s, 0, 0][e], r += [0, 0, s, l, l, s][e], {
                r: Math.round(255 * a),
                g: Math.round(255 * o),
                b: Math.round(255 * r),
                a: n || this.value.a
            }
        },
        toHex: function (e, t, i, n) {
            var a = this.toRGB(e, t, i, n);
            return "#" + (1 << 24 | parseInt(a.r) << 16 | parseInt(a.g) << 8 | parseInt(a.b)).toString(16).substr(1)
        },
        toHSL: function (e, t, i, n) {
            e || (e = this.value.h, t = this.value.s, i = this.value.b);
            var a = e,
                o = (2 - t) * i,
                r = t * i;
            return r /= o > 0 && 1 >= o ? o : 2 - o, o /= 2, r > 1 && (r = 1), {
                h: a,
                s: r,
                l: o,
                a: n || this.value.a
            }
        }
    };
    var i = function (t, i) {
        this.element = e(t);
        var a = i.format || this.element.data("color-format") || "hex";
        this.format = n.translateFormats[a], this.isInput = this.element.is("input"), this.component = this.element.is(".color") ? this.element.find(".add-on") : !1, this.picker = e(n.template).appendTo("body").on("mousedown", e.proxy(this.mousedown, this)), this.isInput ? this.element.on({
            focus: e.proxy(this.show, this),
            keyup: e.proxy(this.update, this)
        }) : this.component ? this.component.on({
            click: e.proxy(this.show, this)
        }) : this.element.on({
            click: e.proxy(this.show, this)
        }), ("rgba" === a || "hsla" === a) && (this.picker.addClass("alpha"), this.alpha = this.picker.find(".colorpicker-alpha")[0].style), this.component ? (this.picker.find(".colorpicker-color").hide(), this.preview = this.element.find("i")[0].style) : this.preview = this.picker.find("div:last")[0].style, this.base = this.picker.find("div:first")[0].style, this.update()
    };
    i.prototype = {
        constructor: i,
        show: function (t) {
            this.picker.show(), this.height = this.component ? this.component.outerHeight() : this.element.outerHeight(), this.place(), e(window).on("resize", e.proxy(this.place, this)), this.isInput || t && (t.stopPropagation(), t.preventDefault()), e(document).on({
                mousedown: e.proxy(this.hide, this)
            }), this.element.trigger({
                type: "show",
                color: this.color
            })
        },
        update: function () {
            this.color = new t(this.isInput ? this.element.prop("value") : this.element.data("color")), this.picker.find("i").eq(0).css({
                left: 100 * this.color.value.s,
                top: 100 - 100 * this.color.value.b
            }).end().eq(1).css("top", 100 * (1 - this.color.value.h)).end().eq(2).css("top", 100 * (1 - this.color.value.a)), this.previewColor()
        },
        setValue: function (e) {
            this.color = new t(e), this.picker.find("i").eq(0).css({
                left: 100 * this.color.value.s,
                top: 100 - 100 * this.color.value.b
            }).end().eq(1).css("top", 100 * (1 - this.color.value.h)).end().eq(2).css("top", 100 * (1 - this.color.value.a)), this.previewColor(), this.element.trigger({
                type: "changeColor",
                color: this.color
            })
        },
        hide: function () {
            this.picker.hide(), e(window).off("resize", this.place), this.isInput ? this.element.prop("value", this.format.call(this)) : (e(document).off({
                mousedown: this.hide
            }), this.component && this.element.find("input").prop("value", this.format.call(this)), this.element.data("color", this.format.call(this))), this.element.trigger({
                type: "hide",
                color: this.color
            })
        },
        place: function () {
            var e = this.component ? this.component.offset() : this.element.offset();
            this.picker.css({
                top: e.top + this.height,
                left: e.left
            })
        },
        previewColor: function () {
            try {
                this.preview.backgroundColor = this.format.call(this)
            } catch (e) {
                this.preview.backgroundColor = this.color.toHex()
            }
            this.base.backgroundColor = this.color.toHex(this.color.value.h, 1, 1, 1), this.alpha && (this.alpha.backgroundColor = this.color.toHex())
        },
        pointer: null,
        slider: null,
        mousedown: function (t) {
            t.stopPropagation(), t.preventDefault();
            var i = e(t.target),
                a = i.closest("div");
            if (!a.is(".colorpicker")) {
                if (a.is(".colorpicker-saturation")) this.slider = e.extend({}, n.sliders.saturation);
                else if (a.is(".colorpicker-hue")) this.slider = e.extend({}, n.sliders.hue);
                else {
                    if (!a.is(".colorpicker-alpha")) return !1;
                    this.slider = e.extend({}, n.sliders.alpha)
                }
                var o = a.offset();
                this.slider.knob = a.find("i")[0].style, this.slider.left = t.pageX - o.left, this.slider.top = t.pageY - o.top, this.pointer = {
                    left: t.pageX,
                    top: t.pageY
                }, e(document).on({
                    mousemove: e.proxy(this.mousemove, this),
                    mouseup: e.proxy(this.mouseup, this)
                }).trigger("mousemove")
            }
            return !1
        },
        mousemove: function (e) {
            e.stopPropagation(), e.preventDefault();
            var t = Math.max(0, Math.min(this.slider.maxLeft, this.slider.left + ((e.pageX || this.pointer.left) - this.pointer.left))),
                i = Math.max(0, Math.min(this.slider.maxTop, this.slider.top + ((e.pageY || this.pointer.top) - this.pointer.top)));
            return this.slider.knob.left = t + "px", this.slider.knob.top = i + "px", this.slider.callLeft && this.color[this.slider.callLeft].call(this.color, t / 100), this.slider.callTop && this.color[this.slider.callTop].call(this.color, i / 100), this.previewColor(), this.element.trigger({
                type: "changeColor",
                color: this.color
            }), !1
        },
        mouseup: function (t) {
            return t.stopPropagation(), t.preventDefault(), e(document).off({
                mousemove: this.mousemove,
                mouseup: this.mouseup
            }), !1
        }
    }, e.fn.colorpicker = function (t, n) {
        return this.each(function () {
            var a = e(this),
                o = a.data("colorpicker"),
                r = "object" == typeof t && t;
            o || a.data("colorpicker", o = new i(this, e.extend({}, e.fn.colorpicker.defaults, r))), "string" == typeof t && o[t](n)
        })
    }, e.fn.colorpicker.defaults = {}, e.fn.colorpicker.Constructor = i;
    var n = {
        translateFormats: {
            rgb: function () {
                var e = this.color.toRGB();
                return "rgb(" + e.r + "," + e.g + "," + e.b + ")"
            },
            rgba: function () {
                var e = this.color.toRGB();
                return "rgba(" + e.r + "," + e.g + "," + e.b + "," + e.a + ")"
            },
            hsl: function () {
                var e = this.color.toHSL();
                return "hsl(" + Math.round(360 * e.h) + "," + Math.round(100 * e.s) + "%," + Math.round(100 * e.l) + "%)"
            },
            hsla: function () {
                var e = this.color.toHSL();
                return "hsla(" + Math.round(360 * e.h) + "," + Math.round(100 * e.s) + "%," + Math.round(100 * e.l) + "%," + e.a + ")"
            },
            hex: function () {
                return this.color.toHex()
            }
        },
        sliders: {
            saturation: {
                maxLeft: 100,
                maxTop: 100,
                callLeft: "setSaturation",
                callTop: "setLightness"
            },
            hue: {
                maxLeft: 0,
                maxTop: 100,
                callLeft: !1,
                callTop: "setHue"
            },
            alpha: {
                maxLeft: 0,
                maxTop: 100,
                callLeft: !1,
                callTop: "setAlpha"
            }
        },
        RGBtoHSB: function (e, t, i, n) {
            e /= 255, t /= 255, i /= 255;
            var a, o, r, s;
            return r = Math.max(e, t, i), s = r - Math.min(e, t, i), a = 0 === s ? null : r == e ? (t - i) / s : r == t ? (i - e) / s + 2 : (e - t) / s + 4, a = 60 * ((a + 360) % 6) / 360, o = 0 === s ? 0 : s / r, {
                h: a || 1,
                s: o,
                b: r,
                a: n || 1
            }
        },
        HueToRGB: function (e, t, i) {
            return 0 > i ? i += 1 : i > 1 && (i -= 1), 1 > 6 * i ? e + 6 * (t - e) * i : 1 > 2 * i ? t : 2 > 3 * i ? e + 6 * (t - e) * (2 / 3 - i) : e
        },
        HSLtoRGB: function (e, t, i, a) {
            0 > t && (t = 0);
            var o;
            o = .5 >= i ? i * (1 + t) : i + t - i * t;
            var r = 2 * i - o,
                s = e + 1 / 3,
                l = e,
                c = e - 1 / 3,
                u = Math.round(255 * n.HueToRGB(r, o, s)),
                d = Math.round(255 * n.HueToRGB(r, o, l)),
                h = Math.round(255 * n.HueToRGB(r, o, c));
            return [u, d, h, a || 1]
        },
        stringParsers: [{
            re: /rgba?\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            parse: function (e) {
                return [e[1], e[2], e[3], e[4]]
            }
        }, {
            re: /rgba?\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            parse: function (e) {
                return [2.55 * e[1], 2.55 * e[2], 2.55 * e[3], e[4]]
            }
        }, {
            re: /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/,
            parse: function (e) {
                return [parseInt(e[1], 16), parseInt(e[2], 16), parseInt(e[3], 16)]
            }
        }, {
            re: /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/,
            parse: function (e) {
                return [parseInt(e[1] + e[1], 16), parseInt(e[2] + e[2], 16), parseInt(e[3] + e[3], 16)]
            }
        }, {
            re: /hsla?\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\)/,
            space: "hsla",
            parse: function (e) {
                return [e[1] / 360, e[2] / 100, e[3] / 100, e[4]]
            }
        }],
        template: '<div class="colorpicker dropdown-menu"><div class="colorpicker-saturation"><i><b></b></i></div><div class="colorpicker-hue"><i></i></div><div class="colorpicker-alpha"><i></i></div><div class="colorpicker-color"><div /></div></div>'
    }
}(window.jQuery);