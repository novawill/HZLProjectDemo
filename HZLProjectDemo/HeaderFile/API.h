//
//  API.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#ifndef API_h
#define API_h

//API
#pragma mark - API
//Music API example：http://mmmono.com/api/v3/meow/pool/?meow_type=8&start=10 (or 20，30,etc) Judging whether it is last page by using is_lastPage property
#define musicAPI @"http://mmmono.com/api/v3/meow/pool/?meow_type=8"

//Album(Paintings) API example: http://mmmono.com/api/v3/meow/pool/?meow_type=9&start=10 (or 20，30,etc) Judging whether it is last page by using is_lastPage property

#define albumAPI @"http://mmmono.com/api/v3/meow/pool/?meow_type=9"

//CheckIn API example:http://mmmono.com/api/v3/group/100353/content/kind/2/?start=994892.0

#define checkInAPI @"http://mmmono.com/api/v3/group/100353/content/kind/2/?"

#define discoveryAPI @"http://mmmono.com/api/v3/new_explore/?"

#endif /* API_h */
