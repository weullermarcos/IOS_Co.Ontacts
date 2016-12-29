//
//  ViewController.m
//  CoOntacts
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _pageTitles = @[@"Bem Vindo ao Co.ontacts", @"Prático e Rápido", @"O Contato Direto"];
    
    _pageContents = @[@"Seus contatos na palma da sua mão", @"De forma rápida e segura", @"A qualquer momento, em qualquer lugar"];
    
    _pageImages = @[@"initialImage4", @"initialImage2", @"initialImage1"];

    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.contentText = self.pageContents[index];
    
    
    pageContentViewController.localImage = [UIImage imageNamed:self.pageImages[index]];
    
    
    
    pageContentViewController.pageIndex = index;
    
  
    
    return pageContentViewController;
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
