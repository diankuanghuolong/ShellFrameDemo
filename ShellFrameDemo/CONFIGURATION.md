README
//基本框架

//1.框架文件下为定义的base基类

//2.tools文件下为常用工具类

//3.VCs文件下为演示VC

//4.基本配置
>
                    （1）TARGETS-Device Orientation下只选Portrait 关闭横竖屏
                    
                    （2）PROJECT-LOcalizations下添加 Chinese（simplified）全选 设置中文环境
                    
                    （3）ios10 以后苹果健康问题配置 ：（根据项目需要设置相关项）plist 中设置
                    
                                    麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
                                    
                                    相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
                                    
                                    相册权限：Application photoLibraryDesciption
                                    
                                    相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
                                    
                                    通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
                                    
                                    蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
                                    
                                    语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
                                    
                                    日历权限：Privacy - Calendars Usage Description 是否允许此App使用日历？
                                    
                                    定位权限：Privacy - Location When In Use Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
                                    
                                    定位权限: Privacy - Location Always Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
                                    
                                    定位的需要这么写，防止上架被拒。
                                    
                                    注：iOS11中相机新加权限：NSPhotoLibraryAddUsageDescription
                                    
                    （4）https 处理 ：（plist中设置）
                    
                                        添加App Transport Security Settings项 ，并加入Allow Arbitrary Loads：YES键值对
                                        
                    （5）PCH文件配置 ： TARGET-Build Settings 下搜索 ：prefix Header 修改路径为相对路径：$(SRCROOT)/项目名/pch文件路径/PrefixHeader.pch
                    
                    （6）URL Schemes 白名单配置：
                    
                    （7）pod文件配置 ：
                    
                                                        platform :ios, '8.0'
                                                        
                                                        target '项目名如：ShellFrameDemo’ do
                                                        
                                                        // 第三方库 例：
                                                        
                                                        pod 'AFNetworking', '~> 3.1.0'
                                                        
                                                        end
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
