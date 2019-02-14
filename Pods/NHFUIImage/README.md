# NHFUIImage
<h2>介绍</h2>
<p>对UIImage的一个扩展，可以对图片进行压缩、通过颜色来拿到图片、计算图片的等比例缩放、裁剪图片等</p>
<h2>安装</h2>
<ul>
<li>pod 'NHFUIImage'</li>
<li>手动下载然后将文件夹拖至工程中即可</li>
</ul>

<h2>使用方法</h2>
+(CGFloat)calculateHeightWithWidth:(CGFloat)width resourceSize:(CGSize)size;</br>
+(CGFloat)calculateWidthWithHeight:(CGFloat)height resourceSize:(CGSize)size;

/**
 *  缩放图片
 *
 *  @param image
 *  @param size
 *
 *  @return
 */
+ (UIImage*)OriginImage:(UIImage *)image
            scaleToSize:(CGSize)size;

/**
 *  压缩图片
 *
 *  @param image
 *  @param thumbSize
 *  @param percent
 *
 *  @return
 */
+ (UIImage*)createThumbImage:(UIImage *)image
                        size:(CGSize )thumbSize
                     percent:(float)percent;


/**
 *  截取图片中间部分
 *
 *  @param image
 *  @param thumbSize
 *  @param percent
 *
 *  @return
 */
+(UIImage*)createCentreImage:(UIImage *)image
                        size:(CGSize )size
                     percent:(float)percent;



/**
 *  进行按比例进行缩比例图片的大小
 *
 *  @param resourceImageSize
 *  @param toBigSize
 *
 *  @return 
 */
+ (CGSize)calculateImageSizeWithResourceImageSize:(CGSize)resourceImageSize
                                        toBigSize:(CGSize)toBigSize;

/**
 *  用于配置SearchBar的背景色
 *
 *  @param color
 *  @param size
 *
 *  @return 
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  压缩图片
 *
 *  @param image
 *  @param maxFileSize
 *
 *  @return 
 */
+ (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

/**
 *  通过颜色来得到图片
 *
 *  @param color
 *
 *  @return
 */
+(UIImage*) imageWithColor:(UIColor*)color;
